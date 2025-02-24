extends CharacterBody2D
class_name Entity

var loss_of_control_effects := []

@onready var velocity_2d := $Velocity2d as Velocity2D
@onready var health := $Health as Health
@onready var hitbox := $Hitbox as Hitbox


func add_loss_of_control_effect(effect_to_add: Variant, remove_signal: Signal) -> void:
	loss_of_control_effects.append(effect_to_add)
	remove_signal.connect(remove_loss_of_control_effect.bind(effect_to_add))


func remove_loss_of_control_effect(effect_to_remove: Variant) -> void:
	loss_of_control_effects.erase(effect_to_remove)
