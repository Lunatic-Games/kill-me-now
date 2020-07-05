extends Node2D


func _unhandled_input(event):
	if event.is_action_pressed("pause") and !$PauseMenu.visible:
		get_tree().paused = true
		$PauseMenu.popup()
		get_tree().set_input_as_handled()
