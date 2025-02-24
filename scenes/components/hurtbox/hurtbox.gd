extends Area2D
class_name Hurtbox


signal impacted()
signal damage_dealt()

@export var damage := 0.0

func _ready() -> void:
	self.area_entered.connect(_on_area_entered)
	self.body_entered.connect(_on_body_entered)


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


func _on_area_entered(area) -> void:
	if area is Hitbox:
		area.deal_damage(damage)
		damage_dealt.emit()


func _on_body_entered(body) -> void:
	if body.get_collision_layer() == 1:
		impacted.emit()
