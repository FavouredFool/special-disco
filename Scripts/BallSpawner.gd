extends Node2D
class_name BallSpawner

onready var player = get_node("../Player")

# Ball
var ball : PackedScene = preload("res://Scenes/Ball.tscn")
var ball_instance : RigidBody2D = null

export var max_throw_strength : float = 300.0
export var min_throw_strength : float = 100.0
export var hold_increase : float = 300

onready var throw_strength = min_throw_strength


func _process(delta):
	if not player.get_node("RingSelection").visible:
		if Input.is_mouse_button_pressed(1):
			if ball_instance:
				return_ball()
			else:
				
				throw_strength += hold_increase * delta
				throw_strength = clamp(throw_strength, min_throw_strength, max_throw_strength)
			
		if Input.is_action_just_released("left_click"):
			if not ball_instance:
				instantiate_ball(get_viewport().get_mouse_position())
			throw_strength = min_throw_strength

func instantiate_ball(var goalPosition : Vector2):
	ball_instance = ball.instance()
	add_child(ball_instance)
	ball_instance.position = player.get_position()
	
	throw_ball(ball_instance, player.get_position(), goalPosition)
	
func return_ball():
	ball_instance.queue_free()
	ball_instance = null

func throw_ball(ball : RigidBody2D, startPosition, goalPosition):
	var forceDirection = (goalPosition - startPosition).normalized() * throw_strength
	ball.apply_impulse(Vector2.ZERO, forceDirection)
