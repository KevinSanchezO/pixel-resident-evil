extends Node2D
class_name ProjectileSpawner

signal projectile_spawned()

const THROW_FORCE := 350.0

@export var fire_rate_value := 0.0
@export var spread := 0.0
@export var weapon : Weapon

@onready var fire_rate := $Firerate as Timer
@onready var muzzle_flash := $MuzzleFlash as AnimatedSprite2D
 

func _ready() -> void:
	muzzle_flash.visible = false
	fire_rate.wait_time = fire_rate_value
	self.projectile_spawned.connect(_on_projectile_spawned)
	muzzle_flash.animation_finished.connect(_on_muzzle_flash_animation_finished)


func _process(_delta) -> void:
	rotation = weapon.rotation


func generate_projectile(projectiles_per_shoot: int, projectile_load:PackedScene, \
spread_range := spread as float) -> void:
	if not fire_rate.is_stopped():
		return
	
	var projectile_layer := get_tree().get_first_node_in_group("projectile_layer") as Node2D
	if projectile_layer == null:
		push_error("No projectile layer found.")
	
	for p in projectiles_per_shoot:
		var projectile_instance := projectile_load.instantiate() as Projectile
		
		projectile_layer.add_child(projectile_instance)
		
		var random_spread := randf_range(-spread_range, spread_range)
		var rotation_projectile := deg_to_rad(rotation_degrees + random_spread)
		projectile_instance.rotate(rotation_projectile)
		projectile_instance.face_direction.rotate(rotation_projectile)
		projectile_instance.spawner = self
		projectile_instance.global_position = self.global_position
	fire_rate.start()
	projectile_spawned.emit()


func launch_projectile(projectiles_per_shoot: int, projectile_load: PackedScene, \
spread_range := spread as float):
	if not fire_rate.is_stopped():
		return
	
	var projectile_layer := get_tree().get_first_node_in_group("projectile_layer") as Node2D
	if projectile_layer == null:
		push_error("No projectile layer found.")
	
	for p in projectiles_per_shoot:
		var projectile_instance := projectile_load.instantiate() #as Projectile
		
		projectile_layer.add_child(projectile_instance)
		
		projectile_instance.global_position = global_position
		
		var direction := (get_global_mouse_position() - projectile_instance.global_position).normalized() as Vector2
		
		var impulse := direction * THROW_FORCE
		projectile_instance.apply_central_impulse(impulse)
	fire_rate.start()
	projectile_spawned.emit()


func _on_projectile_spawned() -> void:
	muzzle_flash.visible = true
	muzzle_flash.play()


func _on_muzzle_flash_animation_finished() -> void:
	muzzle_flash.visible = false
