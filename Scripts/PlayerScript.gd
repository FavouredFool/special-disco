extends KinematicBody2D


const UP_DIRECTION : Vector2 = Vector2.UP

export var speed : float = 600.0

export var jump_strength : float = 1500.0
export var gravity :float = 4500.0

var _velocity : Vector2 = Vector2.ZERO

func _physics_process(delta:float) -> void:
	var _horizontal_direction = (
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	)
	
	_velocity.x = _horizontal_direction * speed
	_velocity.y += gravity * delta
	
	# Get Key Information
	var is_falling : bool = _velocity.y > 0.0 and not is_on_floor()
	var is_jumping : bool = Input.is_action_just_pressed("jump") and is_on_floor()
	var is_jump_cancelled : bool = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var is_idling : bool = is_on_floor() and is_zero_approx(_velocity.x)
	var is_running : bool = is_on_floor() and not is_zero_approx(_velocity.x)
	
	if is_jumping:
		_velocity.y = -jump_strength
	elif is_jump_cancelled:
		_velocity.y = 0.0
	
	_velocity = move_and_slide(_velocity, UP_DIRECTION)
