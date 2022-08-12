extends KinematicBody2D
class_name Dog

signal push_player

onready var ballSpawner : BallSpawner = get_node("/root/Main/BallSpawner")

const UP_DIRECTION : Vector2 = Vector2.UP

export var speed : float = 400.0
export var jump_strength: float = 1000
export var gravity : float = 4500.0
export var ball_margin : float = 5.0
export var _swap_offset : float = 5.0

var _direction : Vector2 = Vector2.RIGHT
var _velocity : Vector2 = Vector2.ZERO
var _desires_jump : bool
var _jump_avaliable : bool
var right = 1


func _physics_process(delta:float) -> void:
	
	if is_on_floor():
		_jump_avaliable = true
	
	if ballSpawner.ball_instance:
		# determine x-direction
		var distance_from_ball : float = (ballSpawner.ball_instance.position - position).length()
		
		if (distance_from_ball > ball_margin):
			if right == 1:
				right = sign(ballSpawner.ball_instance.position.x - position.x + _swap_offset)
			elif right == -1:
				right = sign(ballSpawner.ball_instance.position.x - position.x - _swap_offset)
			else:
				right = sign(ballSpawner.ball_instance.position.x - position.x)
			
		else:
			right = 0
		
		_velocity.x = right * speed
		
		# determine if jump
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.is_in_group("EnvCollider"):
				if collision.normal == -_velocity.normalized():
					_desires_jump = true

		
	else:
		# stand still
		_velocity.x = 0.0


	# Jump
	if _desires_jump:
		_velocity.y = -jump_strength
		_desires_jump = false

	_velocity.y += gravity * delta
	
	_velocity = move_and_slide(_velocity)
