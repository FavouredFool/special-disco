extends Node2D

signal button_green_pressed
signal button_green_released

var plate = preload("res://PressurePlates/PressurePlateGreen.png")
var plate_pressed = preload("res://PressurePlates/PressurePlateGreenPressed.png")

var first_pressed = false
var first_released = false

func _physics_process(delta):
	if $Area2D.get_overlapping_bodies().size() > 0:
		for col in $Area2D.get_overlapping_bodies():
			
			emit_signal("button_green_pressed")
		$Sprite.texture = plate_pressed
		
		if first_pressed:
			$Sound.play()
		
		first_pressed = false
		first_released = true
		
	else:
		emit_signal("button_green_released")
		$Sprite.texture = plate
		
		if first_released:
			$Sound.play()
		
		first_pressed = true
		first_released = false
	
