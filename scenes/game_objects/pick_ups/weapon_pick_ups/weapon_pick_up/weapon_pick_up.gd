extends PickUp
class_name WeaponPickUp

@export var mag_size:int

func _ready() -> void:
	super()
	pick_up_sprite.rotation_degrees = randi_range(-80, 80)
