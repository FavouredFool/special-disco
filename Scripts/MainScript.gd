extends Node

func _process(delta):
	if not $BGMusic.is_playing():
		$BGMusic.play()

func switchScenes(var nodeToDestory, var sceneToSwitchTo):
	nodeToDestory.queue_free()
	var newLevel = load(sceneToSwitchTo)
	
	if newLevel:
		var instance = newLevel.instance()
		add_child(instance)
		
	$ExitAudio.play()

		
func reset(var nodeToDestory, var nodeToReset):
	nodeToDestory.queue_free()
	
	var newLevel = load(nodeToReset)
	
	if newLevel:
		var instance = newLevel.instance()
		add_child(instance)
		
	$RestartAudio.play()
