extends Popup


func _on_BackButton_pressed():
	hide()


func _on_FullscreenCheckBox_pressed():
	var new_value = $VBoxContainer/FullscreenContainer/CheckBox.pressed
	OS.window_fullscreen = new_value


func _on_FullscreenButton_pressed():
	var new_value = !$VBoxContainer/FullscreenContainer/CheckBox.pressed
	$VBoxContainer/FullscreenContainer/CheckBox.pressed = new_value
	OS.window_fullscreen = new_value
