extends Camera2D
class_name GameCamera

var shake_ammount: float = 0
var default_offset: Vector2 = offset
var pos_x: int
var pos_y: int

@onready var timer := $Timer as Timer
@onready var tween := create_tween() as Tween

func _ready() -> void:
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


func _on_timer_timeout():
	set_process(false)
	tween.interpolate_value(self, "offset", 1, 1, tween.TRANS_LINEAR, tween.EASE_IN)
