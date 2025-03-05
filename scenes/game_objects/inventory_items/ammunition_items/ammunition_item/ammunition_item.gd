extends InventoryItem
class_name AmmunitionItem

var ammount:int


func reload(value:int) -> void:
	ammount -= value
	
	if ammount <= 0:
		discarded_item.emit()
	else:
		modified_item.emit()
