extends Node
class_name FrameFreeze

@export var health: Health
@export var duration := 0.5 as float

func _ready():
	health.died.connect(_freeze_frame)

func _freeze_frame():
	FrameFreezeManager.frame_freeze(duration)
