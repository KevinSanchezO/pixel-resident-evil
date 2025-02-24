extends Area2D
class_name Hitbox

@export var health: Health

func enable() -> void:
	for i in get_child_count():
		var child := get_child(i)
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.disabled = false


func disable() -> void:
	for i in get_child_count():
		var child := get_child(i)
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.disabled = true


func deal_damage(value: float) -> void:
	if health == null:
		push_error("No health component detected")
		return
	health.receive_damage(value)
	
