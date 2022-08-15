extends Node2D

export var perm_activated = false
export var reversed = false
var is_open_perm= false
var is_closed_perm= false
var first_frame_released = false
var first_frame_pressed = false
var permTexture = preload("res://Doors/LaserbeamBlueB.png")
var permTextureEmpty = preload("res://Doors/LaserbeamEmptyB.png")
var textureEmpty = preload("res://Doors/LaserbeamEmpty.png")
var texture = preload("res://Doors/LaserbeamBlue.png")

func _ready():
	if perm_activated:
		$Sprite.texture = permTexture
	else:
		$Sprite.texture = texture
		
func _on_ButtonBlue_button_blue_pressed():
	if reversed:
		door_up()
	else:
		door_down()


func _on_ButtonBlue_button_blue_released():
	if reversed:
		door_down()
	else:
		door_up()


func door_down():
	$StaticBody2D/CollisionShape2D.disabled = true
	
	if perm_activated:
		if not is_open_perm:
			if first_frame_pressed:
					$Laser_down.play()
			
			$Sprite.texture = permTextureEmpty
			if not reversed:
				is_open_perm = true
	else:
		$Sprite.texture = textureEmpty
		if reversed:
			if first_frame_pressed:
				$Laser_down.play()
		else:
			if first_frame_pressed:
				$Laser_down.play()
		

	first_frame_released = true
	first_frame_pressed = false


	
func door_up():
	$StaticBody2D/CollisionShape2D.disabled = false
	
	if perm_activated:
		if not is_closed_perm:
			if first_frame_released:
				$Laser_up.play()

			$Sprite.texture = permTexture
			if reversed:
				is_closed_perm = true
	else:
		$Sprite.texture = texture
		if first_frame_released:
			$Laser_up.play()

	first_frame_released = false
	first_frame_pressed = true
