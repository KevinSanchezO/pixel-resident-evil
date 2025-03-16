extends Label
class_name PickedMessage

@export var timer_value := 2.0

@onready var timer = $Timer as Timer


func _ready() -> void:
	timer.timeout.connect(_hide_picked_message)
	
	timer.wait_time = timer_value
	self.text = ""
	self.visible = false


func show_picked_message(pick_up_name="obj") -> void:
	self.text = "Picked " + pick_up_name
	self.visible = true
	timer.start()


func _hide_picked_message() -> void:
	self.visible = false
