extends KinematicBody2D
class_name Dog

signal push_player

onready var ChangeDirectionTimer : Timer = $ChangeDirectionTimer
onready var ballSpawner : BallSpawner = get_node("/root/Main/BallSpawner")

const UP_DIRECTION : Vector2 = Vector2.UP

export var speed : float = 400.0
export var gravity : float = 4500.0

var _direction : Vector2 = Vector2.RIGHT
var _velocity : Vector2 = Vector2.ZERO

func _physics_process(delta:float) -> void:
	
	if ballSpawner.ball_instance:
		var right = sign(ballSpawner.ball_instance.position.x - position.x)
		
		_velocity.x = right * speed
	else:
		_velocity.x = 0.0
	
	
	_velocity.y += gravity * delta
	
	_velocity = move_and_slide(_velocity)
