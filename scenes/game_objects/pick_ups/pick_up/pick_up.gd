extends Node2D
class_name PickUp

@export var inventory_item:PackedScene

func _object_picked() -> void:
	self.queue_free()
