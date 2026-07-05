class_name player extends CharacterBody2D

enum PlayerState {WALKING, STILL}

static var move_speed : float = 250.0
static var rotation_speed : float = PI 
static var player_state : PlayerState = PlayerState.STILL
static var direction : Vector2

func _ready() -> void:
	SignalManager.clock_stop.connect(_on_clock_stop)

func get_move_coeff() -> float:
	var out : float = 0.0
	if Input.is_action_pressed("walk_up"):
		$AnimatedSprite2D.play("walking")
		out += 1.0
	if Input.is_action_pressed("walk_down"):
		$AnimatedSprite2D.play_backwards("walking")
		out += -1.0
	return out

func get_rotate_coeff() -> float:
	var out : float = 0.0
	if Input.is_action_pressed("walk_left"):
		out += - 1.0
	if Input.is_action_pressed("walk_right"):
		out += 1.0
	return out


func _physics_process(delta: float) -> void:
	if game.gamestate != game.GameState.START:
		return
	var move_coeff = get_move_coeff()
	var rotate_coeff = get_rotate_coeff()
	if move_coeff != 0.0 or rotate_coeff != 0.0:
		player_state = PlayerState.WALKING
	else:
		player_state = PlayerState.STILL
	
	match player_state:
		PlayerState.WALKING:
			rotation += rotation_speed * rotate_coeff * delta
			direction = Vector2.UP.rotated(rotation)
			velocity = move_coeff * move_speed * direction
			move_and_slide()
		PlayerState.STILL:
			$AnimatedSprite2D.pause()
		_:
			pass

func _on_clock_stop():
	player_state = PlayerState.STILL
	$AnimatedSprite2D.pause()
