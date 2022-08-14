extends Control

var ball_texture = preload("res://Ball.png")
var no_ball_texture = preload("res://NoBall.png")

func _process(delta):
	var ballSpawner
	var ballSpawnerArray = get_tree().get_nodes_in_group("ball_spawner")
	if ballSpawnerArray.size() > 0:
		ballSpawner = ballSpawnerArray[0]
	if ballSpawner:
		if ballSpawner.ball_is_thrown:
			$Sprite.texture = no_ball_texture
		else:
			$Sprite.texture = ball_texture
