extends RigidBody2D


onready var dog = get_tree().get_nodes_in_group("dog")[0]

var picked_up = false
var prev_picked_up = false
var gravity = 3500
var pickupable = false

var collision_allowed = true

func _ready():
	contact_monitor = true
	contacts_reported = 10
	pickupable = false

func picked_up():
	picked_up = true
	prev_picked_up = true

func dropped():
	queue_free()

func _physics_process(delta):
	if picked_up:
		position = dog.get_node("PickupPosition").global_position
		
	if pickupable:
		for col in $Area2D.get_overlapping_bodies():
			if col.is_in_group("player"):
				get_parent().pickup_ball()
				get_parent().play_sound()
				

	if get_colliding_bodies().size() > 0 and linear_velocity.length() > 40 and collision_allowed:
		collision_allowed = false
		print("SOUND?")
		$CollisionTimer.start()
		
func _on_body_entered(body:Node):
	print(body, " entered")


func _on_Timer_timeout():
	pickupable = true


func _on_CollisionTimer_timeout():
	collision_allowed = true
