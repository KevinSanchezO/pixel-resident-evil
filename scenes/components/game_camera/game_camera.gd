extends Camera2D
class_name GameCamera

var shake_ammount: float = 0
var default_offset: Vector2 = offset
var pos_x: int
var pos_y: int
var current_zoom : Vector2

@onready var timer := $Timer as Timer
@onready var tween := create_tween() as Tween
@onready var unzoom_aim_camera := Vector2(1.0, 1.0)

@export var zoom_aim_camera := Vector2(1.2, 1.2)
@export var zoom_time := 0.1

func _ready() -> void:
	current_zoom = zoom
	
	make_current()
	
	timer.timeout.connect(_on_timer_timeout)
	CameraAccess.camera = self
	
	set_process(true)
	randomize()


func _process(_delta):
	offset = Vector2(randf_range(-1, 1) * shake_ammount, randf_range(-1, 1) * shake_ammount)


func shake(time: float, amount: float):
	timer.wait_time = time
	shake_ammount = amount
	set_process(true)
	timer.start()


func enter_aiming_camera() -> void:
	TweenManager.create_new_tween(self, "zoom", zoom_aim_camera, zoom_time, self.zoom)


func exit_aiming_camera() -> void:
	TweenManager.create_new_tween(self, "zoom", unzoom_aim_camera, zoom_time, self.zoom)


func _on_timer_timeout():
	set_process(false)
	tween.interpolate_value(self, "offset", 1, 1, tween.TRANS_LINEAR, tween.EASE_IN)
