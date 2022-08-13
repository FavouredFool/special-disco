extends Node2D

export var perm_open = false
export var color : Color

func _ready():
	if not perm_open:
		$ColorRect2.visible = true

func _on_ButtonRed_button_red_pressed():
	$StaticBody2D/CollisionShape2D.disabled = true
	$ColorRect.visible = false
	$ColorRect2.visible = false


func _on_ButtonRed_button_red_released():
	if not perm_open:
		$StaticBody2D/CollisionShape2D.disabled = false
		$ColorRect.visible = true
		$ColorRect2.visible = true
