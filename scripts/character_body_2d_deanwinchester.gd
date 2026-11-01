extends CharacterBody2D

const JUMP_VELOCITY = -400.0
const SLIDE_TIME = 0.5

var sliding = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		$deanSprite.play("jump")

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$soundDeanJump.play()
	elif Input.is_action_just_pressed("slide") and is_on_floor():
		sliding_action()
	elif is_on_floor() and not sliding:
		$deanSprite.play("run")

	move_and_slide()

func sliding_action():
	sliding = true
	$deanSprite.play("jump")
	$deanRunningCollision.disabled = true
	$deanSlidingCollision.disabled = false
	$SlideTimer.start(SLIDE_TIME)

func _on_slide_timer_timeout() -> void:
	sliding = false
	$deanRunningCollision.disabled = false
	$deanSlidingCollision.disabled = true
	$deanSprite.play("run")
