extends Control

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_menu"):
		var tree = get_tree()
		if tree.paused:
			tree.paused = false
			hide()
		else:
			tree.paused = true
			show()
