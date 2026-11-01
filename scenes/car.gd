extends Node2D

const WHEEL_RADIUS = 6.0

func _process(delta: float) -> void:
	var main = get_parent()
	var player = main.get_node("Player_Dean")
	position.x = player.position.x - main.gap
	position.y = player.position.y
	$Wheel.rotation += 40.0 * delta
	$Wheel2.rotation += 40.0 * delta
