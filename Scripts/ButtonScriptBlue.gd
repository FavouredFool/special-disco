extends Node2D

signal button_blue_pressed
signal button_blue_released

var plate = preload("res://PressurePlates/PressurePlateBlue.png")
var plate_pressed = preload("res://PressurePlates/PressurePlateBluePressed.png")

func _physics_process(delta):
	if $Area2D.get_overlapping_bodies().size() > 0:
		for col in $Area2D.get_overlapping_bodies():
			emit_signal("button_blue_pressed")
		$Sprite.texture = plate_pressed
	else:
		emit_signal("button_blue_released")
		$Sprite.texture = plate
	
