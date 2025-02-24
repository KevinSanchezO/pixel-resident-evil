extends Node
class_name Health

signal died()
signal health_changed()
signal reached_low_health()

@export var max_health := 100.0
@export_range(0.0, 1.0, 0.1) var low_health_percent := 0.3

@onready var current_health := max_health

var dead: bool:
	get:
		return current_health <= 0


func receive_damage(value: float) -> void:
	if dead:
		return
	
	current_health = maxf(current_health - value, 0.0)
	health_changed.emit()
	
	if get_health_percent() <= low_health_percent:
		reached_low_health.emit()
	
	if dead:
		check_death.call_deferred()


func is_low_health() -> bool:
	return get_health_percent() <= low_health_percent


func get_health_percent() -> float:
	if dead:
		return 0.0
	return minf(current_health / max_health, 1.0)


func check_death() -> void:
	died.emit()
