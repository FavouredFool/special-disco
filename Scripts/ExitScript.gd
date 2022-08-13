extends Node2D




func _physics_process(delta):
	
	var player_in_goal = false
	var dog_in_goal = false
	
	if $Area2D.get_overlapping_bodies().size() >= 2:
		for col in $Area2D.get_overlapping_bodies():
			if col.is_in_group("dog"):
				dog_in_goal = true
			if col.is_in_group("player"):
				player_in_goal = true
				
		if dog_in_goal and player_in_goal:
			print("NEXT LEVEL")

	
