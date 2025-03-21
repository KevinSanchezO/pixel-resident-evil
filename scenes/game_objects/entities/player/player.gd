extends Entity
class_name Player

@export var camera_smoothing := 0.05

@onready var player_sprite := $Visuals/PlayerSprite as Sprite2D
@onready var game_camera := $GameCamera as GameCamera
@onready var pick_up_detector := $PickUpDetector as PickUpDetector
@onready var inventory := $Inventory as Inventory

var aiming:bool
var sprinting:bool

func _process(_delta: float) -> void:
	_handle_camera()


func _physics_process(_delta: float) -> void:
	if loss_of_control_effects != []:
		return

	var movement_vector := get_input_direction() as Vector2

	_handle_aiming()
	_handle_sprint(movement_vector)
	_handle_pick_up()

	velocity_2d.modify_current_speed(_get_velocity())
	velocity_2d.accelerate(movement_vector)
	velocity_2d.move(self)


func get_input_direction() -> Vector2:
	var input_dir = Vector2.ZERO
	input_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_dir = input_dir.normalized()
	return input_dir


func _get_velocity() -> float:
	if aiming:
		return velocity_2d.max_slow_speed
	
	if !sprinting:
		return velocity_2d.max_neutral_speed if !health.is_low_health() else velocity_2d.max_slow_speed
	else:
		return velocity_2d.max_fast_speed if !health.is_low_health() else velocity_2d.max_neutral_speed


func _handle_camera() -> void:
	var new_camera_position = global_position + (get_global_mouse_position() - \
	global_position) * camera_smoothing
	game_camera.global_position = new_camera_position


func _handle_aiming() -> void:
	if Input.is_action_pressed("aim"):
		game_camera.enter_aiming_camera()
		aiming = true
	if Input.is_action_just_released("aim"):
		game_camera.exit_aiming_camera()
		aiming = false


func _handle_sprint(movement_vector:Vector2) -> void:
	if Input.get_action_strength("sprint") and !aiming and- movement_vector != Vector2.ZERO:
		sprinting = true
	else:
		sprinting = false


func _handle_pick_up() -> void:
	if aiming:
		return
	
	if Input.is_action_just_pressed("pick"):
		var pick_up_item := pick_up_detector.get_pick_up()
		inventory.add_item_to_inventory(pick_up_item)
		inventory.inventory_modified.emit()
		inventory.print_inventory()
