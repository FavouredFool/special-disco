extends Node2D

signal button_pressed
signal button_released

func _physics_process(delta):
	if $Area2D.get_overlapping_bodies().size() > 0:
		for col in $Area2D.get_overlapping_bodies():
			emit_signal("button_pressed")
	else:
		emit_signal("button_released")
	
