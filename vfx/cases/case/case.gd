extends CharacterBody2D
class_name Case

const GRAVITY: float = 9.8

var initial_speed: float
var throw_angle_degrees: float
var time := 0.0

var initial_position: Vector2
var throw_direction: Vector2

var z_axis = 0.0 # Simulates throwing the projectile on the z-axis by adding it to the y-axis
var is_launch := false
var time_multiplier := 6.0


@onready var sprite := $Sprite2D as Sprite2D


func _process(delta) -> void:
	if is_launch:
		time += delta * time_multiplier
		z_axis = initial_speed * sin(deg_to_rad(throw_angle_degrees)) * time - 0.5 * GRAVITY * pow(time, 2)
		
		# If hasn't touched the ground yet
		if z_axis > 0:
			var x_axis := initial_speed * cos(deg_to_rad(throw_angle_degrees)) * time
			global_position = initial_position + throw_direction * x_axis # Moves everything
			
			sprite.position.y = -z_axis #Move only the shell in the y axis
			sprite.rotation = time + randi_range(5, 20)
		
		if z_axis <= 0:
			is_launch = false


func launch_projectile(target_position: Vector2, desired_angle_deg: float):
	initial_position = self.global_position
	
	# Calcular la dirección hacia el objetivo
	throw_direction = (target_position - initial_position).normalized()

	# Calcular la distancia hacia el objetivo
	var desired_distance = initial_position.distance_to(target_position)
	
	throw_angle_degrees = desired_angle_deg
	
	# Calcular la velocidad inicial basándonos en la distancia y el ángulo deseado
	initial_speed = pow(desired_distance * GRAVITY / sin(2 * deg_to_rad(throw_angle_degrees)), 0.5)
	
	global_position = initial_position
	time = 0.0
	z_axis = 0
	is_launch = true
