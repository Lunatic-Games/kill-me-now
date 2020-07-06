extends Popup


func _unhandled_input(event):
	if visible and (event.is_action_pressed("pause") or event.is_action_pressed("ui_cancel")):
		get_tree().paused = false
		get_tree().set_input_as_handled()
		hide()


func _on_ContinueButton_pressed():
	get_tree().paused = false
	hide()


func _on_RestartButton_pressed():
	get_tree().paused = false
	var _err = get_tree().reload_current_scene()


func _on_SettingsButton_pressed():
	$Settings.popup()
	$Buttons.visible = false


func _on_QuitButton_pressed():
	get_tree().paused = false
	var _err = get_tree().change_scene("res://menus/main_menu/main_menu.tscn")


func _on_Settings_popup_hide():
	$Buttons.visible = true
	$Buttons/SettingsButton.grab_focus()
