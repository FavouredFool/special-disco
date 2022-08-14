extends Node


func switchScenes(var nodeToDestory, var sceneToSwitchTo):
	nodeToDestory.queue_free()
	print("Switch to: " + sceneToSwitchTo)
	var newLevel = load(sceneToSwitchTo)
	
	if newLevel:
		var instance = newLevel.instance()
		add_child(instance)

		
func reset(var nodeToDestory, var nodeToReset):
	nodeToDestory.queue_free()
	print("reset to: " + nodeToReset)
	
	var newLevel = load(nodeToReset)
	
	if newLevel:
		var instance = newLevel.instance()
		add_child(instance)
