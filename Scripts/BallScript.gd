extends RigidBody2D


onready var dog = get_tree().get_nodes_in_group("dog")[0]

var picked_up = false
var prev_picked_up = false
var gravity = 3500

func picked_up():
	picked_up = true
	prev_picked_up = true

func dropped():
	queue_free()

func _physics_process(delta):
	if picked_up:
		position = dog.get_node("PickupPosition").global_position
