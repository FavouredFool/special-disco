extends Node2D
class_name BallSpawner

onready var player : Player = get_node("/root/Main/Player")

# Ball
var ball : PackedScene = preload("res://Scenes/Ball.tscn")
var ball_instance : RigidBody2D = null

export var throw_strength : float = 300.0

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if not ball_instance:
				instantiate_ball(event.position)
			else:
				return_ball()

func instantiate_ball(var goalPosition : Vector2):
	ball_instance = ball.instance()
	add_child(ball_instance)
	ball_instance.position = player.get_position()
	
	throw_ball(ball_instance, player.get_position(), goalPosition)
	
func return_ball():
	ball_instance.queue_free()
	ball_instance = null
	pass

func throw_ball(ball : RigidBody2D, startPosition, goalPosition):
	var forceDirection = (goalPosition - startPosition).normalized() * throw_strength
	ball.apply_impulse(Vector2.ZERO, forceDirection)
