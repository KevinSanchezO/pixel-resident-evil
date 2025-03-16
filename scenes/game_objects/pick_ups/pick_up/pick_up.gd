extends RigidBody2D
class_name PickUp

@export var inventory_item:PackedScene
@export var pick_up_name:String
@export var visible_pick_up := true

@onready var player_detection := $PlayerDetection as Area2D
@onready var detected_animation := $DetectedAnimation as AnimatedSprite2D
@onready var pick_up_sprite := $PickUpSprite as Sprite2D

func _ready() -> void:
	pick_up_sprite.visible = visible_pick_up
	
	if inventory_item == null:
		push_error("No inventory_item found.")
	
	detected_animation.visible = false
	player_detection.area_entered.connect(_player_detection_on_area_entered)
	player_detection.area_exited.connect(_player_detection_on_area_exited)


func despawn_pick_up() -> void:
	var picked_message_layer := get_tree().get_first_node_in_group("picked_message") as PickedMessage
	if picked_message_layer != null:
		picked_message_layer.show_picked_message(pick_up_name)
		picked_message_layer.global_position = self.global_position
	queue_free()


func _player_detection_on_area_entered(_area) -> void:
	detected_animation.visible = true


func _player_detection_on_area_exited(_area) -> void:
	detected_animation.visible = false
