extends Node


func frame_freeze(duration:float) -> void:
	Engine.time_scale = 0
	
	await get_tree().create_timer(duration, true, false, true).timeout
	
	Engine.time_scale = 1
