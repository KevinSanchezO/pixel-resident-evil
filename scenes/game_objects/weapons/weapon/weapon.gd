extends Node2D
class_name Weapon

@export var time_shake := 0.2
@export var amount_shake := 1.2

@onready var sprite := $Visuals/Sprite as Sprite2D
@onready var animation := $Visuals/AnimationPlayer as AnimationPlayer

var active := false
var aiming := false
var entity:Entity


func shake_screen(_time_shake := time_shake, _amount_shake := amount_shake) -> void:
	CameraAccess.camera.shake(_time_shake, _amount_shake)


func weapon_rotation(mouse_pos: Vector2) -> void:
	look_at(mouse_pos)
	
	if rotation_degrees > 90.0 and rotation_degrees < 270 or \
	rotation_degrees < -90 and rotation_degrees > -270:
		sprite.flip_v = true
	else:
		sprite.flip_v = false


func reset_rotation() -> void:
	if rotation_degrees >= 360 or rotation_degrees <= -360:
		rotation_degrees = 0
