class_name player extends CharacterBody2D

enum PlayerState {WALKING, STILL}

static var speed : float = 100.0
static var direction : Vector2 = Vector2(0.0, -1.0)
static var player_state : PlayerState = PlayerState.STILL

func _ready() -> void:
	SignalManager.clock_stop.connect(_on_clock_stop)

func get_walking_direction() -> Vector2:
	var out : Vector2 = Vector2(0.0, 0.0)
	if Input.is_action_pressed("walk_up"):
		out.y = - 1.0
	if Input.is_action_pressed("walk_right"):
		out.x = 1.0
	if Input.is_action_pressed("walk_down"):
		out.y = 1.0
	if Input.is_action_pressed("walk_left"):
		out.x = - 1.0
	return out.normalized()

func _physics_process(delta: float) -> void:
	if game.gamestate != game.GameState.START:
		return
	var new_direction = get_walking_direction()
	if new_direction != Vector2.ZERO:
		direction = new_direction
		player_state = PlayerState.WALKING
	else:
		player_state = PlayerState.STILL
	
	match player_state:
		PlayerState.WALKING:
			rotation = PI / 2 + direction.angle()
			velocity = direction * speed
			move_and_slide()
			$AnimatedSprite2D.play("walking")
		PlayerState.STILL:
			$AnimatedSprite2D.pause()
		_:
			pass

func _on_clock_stop():
	player_state = PlayerState.STILL
	$AnimatedSprite2D.pause()
