extends Node2D

export var perm_open = false
var is_open = false
var first_frame_released = false
var first_frame_pressed = false
var permTexture = preload("res://Doors/LaserbeamBlueB.png")
var permTextureEmpty = preload("res://Doors/LaserbeamEmptyB.png")
var textureEmpty = preload("res://Doors/LaserbeamEmpty.png")
var texture = preload("res://Doors/LaserbeamBlue.png")

func _ready():
	if perm_open:
		$Sprite.texture = permTexture
	else:
		$Sprite.texture = texture

func _on_ButtonBlue_button_blue_pressed():
	$StaticBody2D/CollisionShape2D.disabled = true
	
	if perm_open:
		if not is_open and first_frame_pressed:
			$Laser_down.play()
			
		$Sprite.texture = permTextureEmpty
		is_open = true
	else:
		$Sprite.texture = textureEmpty
		if first_frame_pressed:
			$Laser_down.play()
		
	first_frame_released = true
	first_frame_pressed = false


func _on_ButtonBlue_button_blue_released():
	if not perm_open:
		$StaticBody2D/CollisionShape2D.disabled = false
		$Sprite.texture = texture
		if first_frame_released:
			$Laser_up.play()
	first_frame_released = false
	first_frame_pressed = true
