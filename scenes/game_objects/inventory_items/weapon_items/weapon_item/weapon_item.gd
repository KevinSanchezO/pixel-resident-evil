extends InventoryItem
class_name WeaponItem

@export var max_rounds_in_chamber:int

var rounds_in_chamber:int


func _ready() -> void:
	rounds_in_chamber = max_rounds_in_chamber
