extends Entity
class_name Player

@export var camera_smoothing := 0.05

@onready var player_sprite := $Visuals/PlayerSprite as Sprite2D
@onready var game_camera := $GameCamera as GameCamera

func _process(_delta: float) -> void:
	_handle_camera()


func _physics_process(_delta: float) -> void:
	if loss_of_control_effects != []:
		return

	if Input.get_action_strength("sprint"):
		velocity_2d.modify_current_speed(_get_velocity(true))
	else:
		velocity_2d.modify_current_speed(_get_velocity(false))

	var movement_vector := get_input_direction() as Vector2
	velocity_2d.accelerate(movement_vector)
	velocity_2d.move(self)


func get_input_direction() -> Vector2:
	var input_dir = Vector2.ZERO
	input_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_dir = input_dir.normalized()
	return input_dir


func _get_velocity(sprint:bool) -> float:
	if !sprint:
		return velocity_2d.max_neutral_speed if !health.is_low_health() else velocity_2d.max_slow_speed
	else:
		return velocity_2d.max_fast_speed if !health.is_low_health() else velocity_2d.max_neutral_speed


func _handle_camera():
	var new_camera_position = global_position + (get_global_mouse_position() - \
	global_position) * camera_smoothing
	game_camera.global_position = new_camera_position
