extends Node2D

onready var main = get_node("/root/Main")

func _physics_process(delta):
	var player_in_goal = false
	
	for col in $Area2D.get_overlapping_bodies():
		if col.is_in_group("player"):
			player_in_goal = true
			
	if player_in_goal:
		main.switchScenes(get_parent(), "res://Levels/Level_" + str(int(get_parent().name) + 1) + ".tscn")

