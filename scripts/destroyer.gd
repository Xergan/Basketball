extends Area2D

@onready var game: Node2D = $"/root/game/"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		if body.global_position.y < global_position.y:
			if !body.is_in_group("granted"):
				%Basket/AnimationPlayer.play("taunt")
				Events.game_over.emit()
		
		body.queue_free()
		await body.tree_exited
		game.spawner()


