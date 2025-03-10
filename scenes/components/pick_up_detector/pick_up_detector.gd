extends Area2D
class_name PickUpDetector


func get_pick_up() -> PickUp:
	var weapon_list = []
	
	for body in get_overlapping_bodies():
		weapon_list.append(body)
	
	if weapon_list.size() <= 0:
		return null
	
	return weapon_list[0]
