extends Node2D
class_name InventoryItem

signal discarded_item()
signal modified_item()

@export var item_image:CompressedTexture2D

func emit_discard() -> void:
	discarded_item.emit()


func emit_modified_item() -> void:
	modified_item.emit()
