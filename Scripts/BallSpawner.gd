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

var ball_is_thrown = false

func _draw():
	if not player.get_node("RingSelection").visible && not ball_is_thrown:
		var draw_goal = player.position + (get_viewport().get_mouse_position() - player.position).normalized() * throw_strength / 8
		
		draw_set_transform_matrix(transform.inverse())
		draw_dashed_line(player.position, draw_goal, Color(1, 1, 1, 1), 5, 10, false)

func _process(delta):
	update()
	if not player.get_node("RingSelection").visible:
		if Input.is_mouse_button_pressed(1):
			if ball_is_thrown:
				#cant throw
				print("no ball")
			else:
				throw_strength += hold_increase * delta
				throw_strength = clamp(throw_strength, min_throw_strength, max_throw_strength)
			
		if Input.is_action_just_released("left_click"):
			if not ball_is_thrown:
				ball_is_thrown = true
				instantiate_ball(get_viewport().get_mouse_position())
			throw_strength = min_throw_strength

func instantiate_ball(var goalPosition : Vector2):
	ball_instance = ball.instance()
	add_child(ball_instance)
	ball_instance.add_to_group("pickupable")
	ball_instance.add_to_group("ball")
	ball_instance.position = player.get_position()
	
	throw_ball(ball_instance, player.get_position(), goalPosition)
	
func return_ball():
	ball_instance.queue_free()
	ball_instance = null

func throw_ball(ball : RigidBody2D, startPosition, goalPosition):
	ball_instance.get_node("Timer").start()
	player.get_node("CharacterRig/AnimationPlayer").play("throw")
	var forceDirection = (goalPosition - startPosition).normalized() * throw_strength
	ball.apply_impulse(Vector2.ZERO, forceDirection)
	
func instantiate_ball_for_dog(var position : Vector2):
	ball_instance = ball.instance()
	add_child(ball_instance)
	ball_instance.add_to_group("pickupable")
	ball_instance.add_to_group("ball")
	ball_instance.position = position
	ball_instance.pickupable = true
	
func pickup_ball():
	ball_is_thrown = false
	return_ball()
		
func draw_dashed_line(from, to, color, width, dash_length = 5, cap_end = false, antialiased = false):
	#https://github.com/juddrgledhill/godot-dashed-line
	var length = (to - from).length()
	var normal = (to - from).normalized()
	var dash_step = normal * dash_length
	
	if length < dash_length: #not long enough to dash
		draw_line(from, to, color, width, antialiased)
		return

	else:
		var draw_flag = true
		var segment_start = from
		var steps = length/dash_length
		for start_length in range(0, steps + 1):
			var segment_end = segment_start + dash_step
			if draw_flag:
				draw_line(segment_start, segment_end, color, width, antialiased)

			segment_start = segment_end
			draw_flag = !draw_flag
		
		if cap_end:
			draw_line(segment_start, to, color, width, antialiased)
