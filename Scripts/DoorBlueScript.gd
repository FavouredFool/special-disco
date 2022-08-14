extends Node2D

export var perm_open = false

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
		$Sprite.texture = permTextureEmpty
	else:
		$Sprite.texture = textureEmpty
		


func _on_ButtonBlue_button_blue_released():
	if not perm_open:
		$StaticBody2D/CollisionShape2D.disabled = false
		$Sprite.texture = texture
