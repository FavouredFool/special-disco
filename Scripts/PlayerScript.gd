extends KinematicBody2D
class_name Player

# onready
onready var CoyoteTimer : Timer = $CoyoteTimer

# constants
const UP_DIRECTION : Vector2 = Vector2.UP

# export variables
export var speed : float = 300.0
export var jump_strength : float = 1000.0
export var gravity : float = 4500.0

# fields
var _velocity : Vector2 = Vector2.ZERO
var _jump_avaliable : bool
var _horizontal_direction : float
var _desires_jump : bool

func _process(delta):
	_horizontal_direction = (
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	)
	
	if not _desires_jump:
		_desires_jump = Input.is_action_just_pressed("jump") and _jump_avaliable

func _physics_process(delta:float) -> void:
	
	_velocity.x = _horizontal_direction * speed
	_velocity.y += gravity * delta
	
	if is_on_floor():
		_jump_avaliable = true
	elif _jump_avaliable and CoyoteTimer.is_stopped():
		CoyoteTimer.start()
	
	# Get Key Information
	var is_falling : bool = _velocity.y > 0.0 and not is_on_floor()
	var is_jump_cancelled : bool = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var is_idling : bool = is_on_floor() and is_zero_approx(_velocity.x)
	var is_running : bool = is_on_floor() and not is_zero_approx(_velocity.x)
	
	if _desires_jump:
		_velocity.y = -jump_strength
		_desires_jump = false
	elif is_jump_cancelled:
		_velocity.y = 0.0
	
	_velocity = move_and_slide(_velocity, UP_DIRECTION)

func _on_Timer_timeout():
	_jump_avaliable = false
