extends Node2D

export var perm_open = false

var permTexture = preload("res://Doors/LaserbeamRedB.png")
var permTextureEmpty = preload("res://Doors/LaserbeamEmptyB.png")
var textureEmpty = preload("res://Doors/LaserbeamEmpty.png")
var texture = preload("res://Doors/LaserbeamRed.png")

func _ready():
	if perm_open:
		$Sprite.texture = permTexture
	else:
		$Sprite.texture = texture

func _on_ButtonRed_button_red_pressed():
	$StaticBody2D/CollisionShape2D.disabled = true
	if perm_open:
		$Sprite.texture = permTextureEmpty
	else:
		$Sprite.texture = textureEmpty
		


func _on_ButtonRed_button_red_released():
	if not perm_open:
		$StaticBody2D/CollisionShape2D.disabled = false
		$Sprite.texture = texture
