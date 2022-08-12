extends KinematicBody2D
class_name Player

# onready
onready var CoyoteTimer : Timer = $CoyoteTimer
onready var dog : KinematicBody2D = get_node("/root/Main/Dog")
onready var animationPlayer : AnimationPlayer = get_node("./CharacterRig/AnimationPlayer")

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

var _ballSpawnPoint : Vector2 = Vector2.ZERO

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			
			if $RingSelection.visible:
				# ring selection logic
				
				var mouse_position = get_viewport().get_mouse_position()
				
				var direction : Vector2 = mouse_position - position
				
				var angle = Vector2.UP.angle_to(direction)
				
				if angle > 0.0:
					#positive angles
					if angle < PI/4:
						# feature top
						print("TOP")
						dog.active_command = dog.ActiveCommand.STAY
					elif angle < 3*PI/4:
						# feature right
						print("RIGHT")
						dog.first_come_frame = true
						dog.active_command = dog.ActiveCommand.COME
					else:
						# feature down
						print("DOWN")
						dog.active_command = dog.ActiveCommand.DROP_PICKUP
						
				elif angle < 0.0:
					if angle > -PI/4:
						# feature top
						print("TOP")
						dog.active_command = dog.ActiveCommand.STAY
					elif angle > -3*PI/4:
						# feature left
						print("LEFT")
						dog.active_command = dog.ActiveCommand.FETCH
					else:
						# feature down
						print("DOWN")
						dog.active_command = dog.ActiveCommand.DROP_PICKUP

func _process(delta):
	_horizontal_direction = (
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	)
	
	if not _desires_jump:
		_desires_jump = Input.is_action_just_pressed("jump") and _jump_avaliable
		
	if Input.is_mouse_button_pressed(2):
		$RingSelection.visible = true
	else:
		$RingSelection.visible = false
	
	var scaleX = animationPlayer.get_parent().get_scale().x
	
	if sign(_velocity.x) < 0:
		scaleX = abs(animationPlayer.get_parent().get_scale().x)
	elif sign(_velocity.x) > 0:
		scaleX = -abs(animationPlayer.get_parent().get_scale().x)
		
	animationPlayer.get_parent().set_scale(Vector2(scaleX, animationPlayer.get_parent().get_scale().y))
	
	if _velocity.is_equal_approx(Vector2.ZERO):
		animationPlayer.play("idle")
	else:
		animationPlayer.play("walk", 0.15)
		



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
