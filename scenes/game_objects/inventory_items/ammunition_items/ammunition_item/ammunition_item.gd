extends InventoryItem
class_name AmmunitionItem

enum types {PISTOL, SHOTGUN, RIFLE, GRENADE, MAGNUM}

@export var amount:int
@export var type:types

var current_amount:int

func _ready() -> void:
	current_amount = amount


func reload(value:int) -> void:
	current_amount -= value
	
	if current_amount <= 0:
		discarded_item.emit()
	else:
		modified_item.emit()
