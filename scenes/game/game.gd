class_name game extends Node2D

enum GameState {START, STOP}

static var gamestate : GameState = GameState.STOP
static var clock_length : float

func _ready() -> void:
	clock_length = 3.0
	SignalManager.clock_start.connect(_on_clock_start)
	SignalManager.clock_stop.connect(_on_clock_stop)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("rotate"):
		gamestate = GameState.START
		SignalManager.clock_start.emit(clock_length)

func _on_clock_start() -> void:
	print("Clock started")
	
func _on_clock_stop() -> void:
	print("Clock stopped")
	gamestate = GameState.STOP
	pass


func _on_add_time_button_button_down() -> void:
	SignalManager.clock_add_time.emit(1.0)
