extends RigidBody2D

const CLICK_THRESHOLD := 126.0
const FLICK_POWER = 2800.0
var is_dragging: bool = false
var is_throwed: bool = false

func _ready() -> void:
	gravity_scale = 3
	linear_damp = 1
	linear_damp_mode = DAMP_MODE_REPLACE

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and not is_in_group("granted"):
		if event.is_pressed() and (event.global_position - global_position).length() < CLICK_THRESHOLD:
			if not is_throwed:
				%AnimationPlayer.play("drag")
			is_dragging = true
		elif is_dragging:
			is_dragging = false
			if (event.global_position - global_position).length() > CLICK_THRESHOLD:
				var flick_vector: Vector2 = (event.global_position - global_position)
				var velocity = flick_vector.normalized() * FLICK_POWER 
				apply_central_impulse(velocity)
				apply_torque_impulse(velocity.x * 10)
				if not is_throwed:
					is_throwed = true
					%AnimationPlayer.play("throw")
			else:
				if not is_throwed:
					%AnimationPlayer.play("RESET")
