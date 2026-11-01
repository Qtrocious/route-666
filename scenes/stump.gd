extends Area2D

func _process(delta: float) -> void:
	position.x -= get_node("/root/Main").speed * delta
	if position.x < -50:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player_Dean":
		get_node("/root/Main").hit_obstacle()
		queue_free()
