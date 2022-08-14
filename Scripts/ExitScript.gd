extends Node2D

onready var main = get_node("/root/Main")

export var level_nr : int = 1

func _physics_process(delta):
	var player_in_goal = false
	
	for col in $Area2D.get_overlapping_bodies():
		if col.is_in_group("player"):
			player_in_goal = true
			
	if player_in_goal:
		main.switchScenes(get_parent(), "res://Levels/Level_" + str(level_nr + 1) + ".tscn")

func _process(delta):
	if Input.is_action_just_pressed("reset"):
		main.reset(get_parent(),  "res://Levels/Level_" + str(level_nr) + ".tscn")
