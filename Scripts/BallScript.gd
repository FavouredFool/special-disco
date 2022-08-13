extends RigidBody2D


onready var dog = get_tree().get_nodes_in_group("dog")[0]

var picked_up = false
var prev_picked_up = false
var gravity = 3500

func picked_up():
	picked_up = true
	prev_picked_up = true

func dropped():
	picked_up = false
	apply_impulse(Vector2.ZERO, Vector2(0, 0))

func _physics_process(delta):
	if picked_up:
		position = dog.get_node("PickupPosition").global_position
