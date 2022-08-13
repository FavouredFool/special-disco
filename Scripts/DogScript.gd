extends KinematicBody2D
class_name Dog

signal push_player

onready var ballSpawner : BallSpawner = get_node("../BallSpawner")
onready var player : KinematicBody2D = get_node("../Player")
onready var animationPlayer : AnimationPlayer = get_node("./DogRig/AnimationPlayer")

const UP_DIRECTION : Vector2 = Vector2.UP

export var speed : float = 400.0
export var jump_strength: float = 1000
export var gravity : float = 4500.0
export var ball_margin : float = 5.0

export var _swap_offset : float = 5.0
var player_min_margin : float = 70.0
var player_max_margin : float = 170.0


var _direction : Vector2 = Vector2.RIGHT
var _velocity : Vector2 = Vector2.ZERO
var _desires_jump : bool
var _jump_avaliable : bool
var right = 1
enum ActiveCommand { STAY, COME, FETCH, POOP, SPEAK, DROP_PICKUP }
var active_command = ActiveCommand.STAY

var last_command = ActiveCommand.STAY

# come
var come_to_player : bool = false
var first_command_frame : bool = false

func _process(delta):
	var scaleX = animationPlayer.get_parent().get_scale().x
	
	if sign(_velocity.x) > 0:
		scaleX = abs(animationPlayer.get_parent().get_scale().x)
	elif sign(_velocity.x) < 0:
		scaleX = -abs(animationPlayer.get_parent().get_scale().x)
		
	animationPlayer.get_parent().set_scale(Vector2(scaleX, animationPlayer.get_parent().get_scale().y))
	
	var is_falling : bool = _velocity.y > 0.0 and not is_on_floor()

	if is_on_floor():
		if _velocity.x == 0:
			animationPlayer.play("idle")
		else:
			animationPlayer.play("walk", 0.15)
			

func _physics_process(delta:float) -> void:
	
	if is_on_floor():
		_jump_avaliable = true
	
	match active_command:
		ActiveCommand.STAY:
			command_stay()
		ActiveCommand.COME:
			command_come()
		ActiveCommand.FETCH:
			command_fetch()
		ActiveCommand.DROP_PICKUP:
			command_drop_pickup()
		ActiveCommand.SPEAK:
			command_speak()
		ActiveCommand.POOP:
			command_poop()
			
	first_command_frame = false
	

	# Jump
	if _desires_jump:
		animationPlayer.play("jump", 0.15, 2.0)
		_velocity.y = -jump_strength
		_desires_jump = false

	_velocity.y += gravity * delta
	
	_velocity = move_and_slide(_velocity, Vector2.UP)


func command_stay():
	_velocity.x = 0.0
	active_command = ActiveCommand.STAY

func command_come():
	
	if first_command_frame:
		come_to_player = true
	
	if player:
		# determine x-direction
		var distance_from_player : float = (player.position - position).length()
		#var horizontal_distance_from_player : float = player.position.x - position.x
		
		if not come_to_player:
			come_to_player = distance_from_player > player_max_margin
		
		if (distance_from_player > player_min_margin and come_to_player):
			if right == 1:
				right = sign(player.position.x - position.x + _swap_offset)
			elif right == -1:
				right = sign(player.position.x - position.x - _swap_offset)
			else:
				right = sign(player.position.x - position.x)
			
		else:
			right = 0
			come_to_player = false
		
		_velocity.x = right * speed
		
		# determine if jump
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.is_in_group("EnvCollider"):
				if collision.normal == -_velocity.normalized():
					_desires_jump = true

	else:
		# stand still
		set_active_dog_command(ActiveCommand.STAY)
		
	first_command_frame = false
	
func command_fetch():
	
	if ballSpawner.ball_instance:
		# determine x-direction
		var distance_from_ball : float = (ballSpawner.ball_instance.position - position).length()
		
		if (distance_from_ball > ball_margin):
			if right == 1:
				right = sign(ballSpawner.ball_instance.position.x - position.x + _swap_offset)
			elif right == -1:
				right = sign(ballSpawner.ball_instance.position.x - position.x - _swap_offset)
			else:
				right = sign(ballSpawner.ball_instance.position.x - position.x)
			
		else:
			right = 0
		
		_velocity.x = right * speed
		
		# determine if jump
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.is_in_group("EnvCollider") or collision.collider.is_in_group("player"):
				if collision.normal == -_velocity.normalized():
					_desires_jump = true

	else:
		# stand still
		set_active_dog_command(last_command)
	
func command_drop_pickup():
	# drop / pickup
	set_active_dog_command(ActiveCommand.STAY)

func command_speak():
	# speak
	set_active_dog_command(ActiveCommand.STAY)
	
func command_poop():
	# poop
	set_active_dog_command(ActiveCommand.STAY)

	
func set_active_dog_command(dog_command):
	last_command = active_command
	first_command_frame = true
	active_command = dog_command
