class_name clock_system extends Node2D

var rotation_speed : float
static var rotate_state : bool = false
static var max_time : float
static var time_left : float

func _ready() -> void:
	SignalManager.clock_add_time.connect(_on_clock_add_time)
	SignalManager.clock_start.connect(start_clock)

func _process(delta: float) -> void:
	if rotate_state:
		rotate_clock(delta)

func start_clock(_max_time : float):
	if rotate_state:
		return
	max_time = _max_time
	time_left = max_time
	rotation_speed = PI * 2 / max_time
	
	$ClockHand.rotation = 0.0
	rotate_state = true

func rotate_clock(delta : float):
	time_left = clamp(time_left - delta, 0.0, max_time)
	$ClockHand.rotation = 2 * PI - (rotation_speed * time_left)
	if time_left == 0.0:
		rotate_state = false
		SignalManager.clock_stop.emit()

func _on_clock_add_time(value : float):
	rotate_clock(- value)
