extends Node2D

signal button_blue_pressed
signal button_blue_released

var plate = preload("res://PressurePlates/PressurePlateBlue.png")
var plate_pressed = preload("res://PressurePlates/PressurePlateBluePressed.png")
var plate_pressed_perm = preload("res://PressurePlates/PressurePlateBluePressedB.png")
var plate_perm = preload("res://PressurePlates/PressurePlateBlueB.png")

export var perm_open = false

var first_pressed = false
var first_released = false

func _ready():
	if perm_open:
		$Sprite.texture = plate_perm
	else:
		$Sprite.texture = plate


func _physics_process(delta):
	if $Area2D.get_overlapping_bodies().size() > 0:
		for col in $Area2D.get_overlapping_bodies():
			emit_signal("button_blue_pressed")
			
		if perm_open:
			$Sprite.texture = plate_pressed_perm
		else:
			$Sprite.texture = plate_pressed
		
		if first_pressed:
			$Sound.play()
		
		first_pressed = false
		first_released = true
	
	else:
		emit_signal("button_blue_released")
		
		if perm_open:
			$Sprite.texture = plate_perm
		else:
			$Sprite.texture = plate
		
		if first_released:
			$Sound.play()
		
		first_pressed = true
		first_released = false
