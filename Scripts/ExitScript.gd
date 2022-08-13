extends Node2D

func _physics_process(delta):
	
	var player_in_goal = false
	
	for col in $Area2D.get_overlapping_bodies():
		if col.is_in_group("player"):
			player_in_goal = true
			
	if player_in_goal:
		print("NEXT LEVEL")
		get_tree().change_scene("res://Levels/Level_" + str(int(get_parent().name) + 1) + ".tscn")

