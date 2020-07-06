extends Popup


func _ready():
	var level = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	var master_slider = $VBoxContainer/MasterSlider/MarginContainer/Slider
	master_slider.value = master_slider.max_value * db2linear(level)
	
	level = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	var music_slider = $VBoxContainer/MusicSlider/MarginContainer/Slider
	music_slider.value = music_slider.max_value * db2linear(level)
	
	level = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
	var sfx_slider = $VBoxContainer/SFXSlider/MarginContainer/Slider
	sfx_slider.value = sfx_slider.max_value * db2linear(level)
	
	$VBoxContainer/FullscreenContainer/CheckBox.pressed = OS.window_fullscreen


func _unhandled_input(event):
	if visible and (event.is_action_pressed("ui_back") or event.is_action_pressed("pause")):
		get_tree().set_input_as_handled()
		hide()
		

func _on_BackButton_pressed():
	hide()


func popup(_rect=null):
	.popup()
	$VBoxContainer/FullscreenContainer/FullscreenButton.grab_focus()


func _on_FullscreenCheckBox_pressed():
	var new_value = $VBoxContainer/FullscreenContainer/CheckBox.pressed
	OS.window_fullscreen = new_value


func _on_FullscreenButton_pressed():
	var new_value = !$VBoxContainer/FullscreenContainer/CheckBox.pressed
	$VBoxContainer/FullscreenContainer/CheckBox.pressed = new_value
	OS.window_fullscreen = new_value



func _on_MasterSlider_value_changed(value):
	var ratio = value / $VBoxContainer/MasterSlider/MarginContainer/Slider.max_value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),
		linear2db(ratio))


func _on_MusicSlider_value_changed(value):
	var ratio = value / $VBoxContainer/MusicSlider/MarginContainer/Slider.max_value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),
		linear2db(ratio))


func _on_SFXSlider_value_changed(value):
	var ratio = value / $VBoxContainer/SFXSlider/MarginContainer/Slider.max_value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),
		linear2db(ratio))
