extends Node2D
class_name PickedMessage

@export var inventory:Inventory
@export var timer_value := 3.0

@onready var label = $Label as Label
@onready var timer = $Timer as Timer


func _ready() -> void:
	inventory.inventory_modified.connect(_show_picked_message)
	timer.timeout.connect(_hide_picked_message)
	
	timer.wait_time = timer_value
	label.text = ""
	label.visible = false


func _show_picked_message() -> void:
	label.text = "Picked " + inventory.last_item_picked_name
	label.visible = true
	timer.start()


func _hide_picked_message() -> void:
	label.visible = false
