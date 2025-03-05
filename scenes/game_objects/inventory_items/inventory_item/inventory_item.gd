extends Node2D
class_name InventoryItem

signal discarded_item()
signal modified_item()

@export var game_object:PackedScene
@export var sprite:Image
