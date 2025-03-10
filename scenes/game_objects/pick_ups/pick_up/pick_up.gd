extends RigidBody2D
class_name PickUp

@export var inventory_item:PackedScene

@onready var player_detection := $PlayerDetection as Area2D
@onready var detected_animation := $DetectedAnimation as AnimatedSprite2D

func _ready() -> void:
	detected_animation.visible = false
	player_detection.area_entered.connect(_player_detection_on_area_entered)
	player_detection.area_exited.connect(_player_detection_on_area_exited)


func despawn_pick_up() -> void:
	queue_free()


func _player_detection_on_area_entered(_area) -> void:
	detected_animation.visible = true


func _player_detection_on_area_exited(_area) -> void:
	detected_animation.visible = false
