extends Node2D

signal button_green_pressed
signal button_green_released

var plate = preload("res://PressurePlates/PressurePlateGreen.png")
var plate_pressed = preload("res://PressurePlates/PressurePlateGreenPressed.png")

func _physics_process(delta):
	if $Area2D.get_overlapping_bodies().size() > 0:
		for col in $Area2D.get_overlapping_bodies():
			
			emit_signal("button_green_pressed")
		$Sprite.texture = plate_pressed
	else:
		emit_signal("button_green_released")
		$Sprite.texture = plate
	
