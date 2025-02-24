extends Node
class_name Velocity2D

@export_range(0.0, 4000.0, 10.0) var max_slow_speed := 400.0
@export_range(0.0, 4000.0, 10.0) var max_neutral_speed := 400.0
@export_range(0.0, 4000.0, 10.0) var max_fast_speed := 400.0
@export_range(0.0, 400.0, 5.0) var acceleration := 50.0
@export_range(0.0, 2.0, 0.1) var switch_speed_duration := 0.5

var velocity := Vector2.ZERO

var current_speed : float

func modify_current_speed(new_speed:float) -> void:
	TweenManager.create_new_tween(self, "current_speed", new_speed, \
		switch_speed_duration, current_speed)


func accelerate(direction: Vector2, speed := current_speed as float) -> void:
	var desired_velocity := direction * speed
	velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration * get_process_delta_time()))


func accelerate_in_direction(direction: Vector2, speed := current_speed as float) -> void:
	var desired_velocity := direction * speed
	velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration * get_process_delta_time()))


func move(body:CharacterBody2D) -> void:
	body.velocity = velocity
	body.move_and_slide()
