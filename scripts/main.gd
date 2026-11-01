extends Node

const PLAYER_X := 100.0
const GROUND_Y := 191.0   # Player_Dean's feet land exactly on the ground's top edge

var score : float = 0.0
var speed : float = 200.0
const MAX_SPEED := 400.0
const SPEED_RAMP := 4.0

var gap : float = 150.0
const MAX_GAP := 200.0
const REGEN_RATE := 15.0
const HIT_PENALTY := 60.0
var alive := true

const TILE_WIDTH := 960.0
var stump_scene = preload("res://scenes/stump.tscn")

func _ready() -> void:
	new_game()

func new_game() -> void:
	score = 0.0
	speed = 200.0
	gap = 150.0
	alive = true
	$Player_Dean.position = Vector2(PLAYER_X, GROUND_Y)
	$Player_Dean.velocity = Vector2.ZERO
	$ground.position.x = 0
	$Ground2.position.x = TILE_WIDTH
	get_tree().call_group("obstacles", "queue_free")
	$SpawnTimer.start()
	$HUD.get_node("StartLabel").hide()

func _process(delta: float) -> void:
	if not alive:
		return
	speed = min(speed + SPEED_RAMP * delta, MAX_SPEED)
	score += speed * delta * 0.1
	show_score()

	gap = min(gap + REGEN_RATE * delta, MAX_GAP)
	if gap <= 0.0:
		alive = false
		_on_crushed()
		return

	$ground.position.x -= speed * delta
	$Ground2.position.x -= speed * delta
	if $ground.position.x <= -TILE_WIDTH:
		$ground.position.x = $Ground2.position.x + TILE_WIDTH
	if $Ground2.position.x <= -TILE_WIDTH:
		$Ground2.position.x = $ground.position.x + TILE_WIDTH

func hit_obstacle() -> void:
	gap -= HIT_PENALTY

func _on_spawn_timer_timeout() -> void:
	var s = stump_scene.instantiate()
	s.position = Vector2(500, GROUND_Y)
	s.add_to_group("obstacles")
	add_child(s)
	$SpawnTimer.wait_time = randf_range(1.0, 2.0)

func _on_crushed() -> void:
	$HUD.get_node("scoreLabel").text = "CRUSHED! Score: " + str(int(score))

func show_score() -> void:
	$HUD.get_node("scoreLabel").text = "SCORE: " + str(int(score))
