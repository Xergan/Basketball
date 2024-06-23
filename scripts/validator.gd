extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball") and not body.is_in_group("granted"):
		if body.global_position.y < global_position.y - body.get_node("CollisionShape2D").shape.radius/2:
			body.add_to_group("granted")
			Events.player_scored.emit(1)
			%AnimationPlayer.play("celebrate")
