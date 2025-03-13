extends Node
class_name Inventory

signal inventory_modified()
signal item_removed()
signal inventory_filled()

const MAX_ITEM_COUNT := 6
var item_list := []
var last_item_picked_name:String

func add_item_to_inventory(pick_up:PickUp) -> void:
	if pick_up == null:
		return
	
	if self.get_child_count() == MAX_ITEM_COUNT:
		inventory_filled.emit()
		return

	var item_instance = pick_up.inventory_item.instantiate()
	
	pick_up.despawn_pick_up()
	if item_instance is AmmunitionItem:
		_update_ammo_item(item_instance)
		return
	self.add_child(item_instance)
	last_item_picked_name = item_instance.item_name
	inventory_modified.emit()


func _update_ammo_item(item_instance:AmmunitionItem):
	for i in get_child_count():
		var child := get_child(i)
		if child.type == item_instance.type:
			child.current_amount += item_instance.amount
			return
	self.add_child(item_instance)
	last_item_picked_name = item_instance.item_name
	inventory_modified.emit()


func print_inventory() -> void:
	print("[ INVENTORY ]")
	for i in get_child_count():
		var child := get_child(i)
		if child is AmmunitionItem:
			print(child, child.current_amount)
		else:
			print(child)
