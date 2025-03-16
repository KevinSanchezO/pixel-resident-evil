extends Node2D
class_name CaseSpawner

@export var case_scene : PackedScene
@export var desired_angle_deg := 60.0

@onready var landing_point := $LandingPoint as Node2D

func spawn_case() -> void:
	var case_layer := get_tree().get_first_node_in_group("case_layer") as Node2D
	if case_layer == null:
		push_error("No case layer was found.")
	
	var case_instance := case_scene.instantiate()
	case_layer.add_child(case_instance)
	
	case_instance.global_position = self.global_position
	case_instance.launch_case(landing_point.global_position, desired_angle_deg)
