extends Node2D

signal button_red_pressed
signal button_red_released

var plate = preload("res://PressurePlates/PressurePlateRed.png")
var plate_pressed = preload("res://PressurePlates/PressurePlateRedPressed.png")

func _physics_process(delta):
	if $Area2D.get_overlapping_bodies().size() > 0:
		for col in $Area2D.get_overlapping_bodies():
			emit_signal("button_red_pressed")
		$Sprite.texture = plate_pressed
		
	else:
		emit_signal("button_red_released")
		$Sprite.texture = plate
	
