extends KinematicBody2D
class_name Dog

signal push_player

onready var ChangeDirectionTimer : Timer = $ChangeDirectionTimer

const UP_DIRECTION : Vector2 = Vector2.UP

export var speed : float = 400.0
export var gravity : float = 4500.0

var _direction : Vector2 = Vector2.RIGHT
var _velocity : Vector2 = Vector2.ZERO

func _physics_process(delta:float) -> void:
	
	_velocity.x = _direction.x * speed
	_velocity.y += gravity * delta
	_velocity = move_and_slide(_velocity)

func _on_ChangeDirectionTimer_timeout():
	_direction = -_direction
