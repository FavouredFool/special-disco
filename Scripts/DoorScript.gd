extends Node2D

func _on_Button_button_pressed():
	$StaticBody2D/CollisionShape2D.disabled = true
	$ColorRect.visible = false


func _on_Button_button_released():
	$StaticBody2D/CollisionShape2D.disabled = false
	$ColorRect.visible = true
