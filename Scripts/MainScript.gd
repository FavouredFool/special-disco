extends Node

var not_started = true

func _unhandled_key_input(event):
	if not_started:
		startFirstLevel()
	
func startFirstLevel():
	not_started = false
	if $TitleScreen.visible:
			$TitleScreen.visible = false
			
			var newLevel = load("res://Levels/Level_1.tscn")
				
			if newLevel:
				var instance = newLevel.instance()
				add_child(instance)
				$RestartAudio.play()

func _process(delta):
	if not $BGMusic.is_playing():
		$BGMusic.play()
		
	if not_started:
		if Input.is_action_just_pressed("left_click") or Input.is_action_just_pressed("right_click"):
			startFirstLevel()

func switchScenes(var nodeToDestory, var sceneToSwitchTo, var levelNr):
	
	nodeToDestory.queue_free()
	
	if not levelNr == 12:
		var newLevel = load(sceneToSwitchTo)
		if newLevel:
			var instance = newLevel.instance()
			add_child(instance)
			
		$ExitAudio.play()
	else:
		$EndScreen.visible = true

		
func reset(var nodeToDestory, var nodeToReset):
	nodeToDestory.queue_free()
	
	var newLevel = load(nodeToReset)
	
	if newLevel:
		var instance = newLevel.instance()
		add_child(instance)
		
	$RestartAudio.play()
