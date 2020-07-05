extends Control


func _ready():
	$Options/NewGameButton.grab_focus()


func _on_NewGameButton_pressed():
	$AnimationPlayer.play("fade_out")


func begin_new_game():
	var _err = get_tree().change_scene("res://levels/train_station_1.tscn")


func _on_LevelSelectButton_pressed():
	$Title.visible = false
	$Options.visible = false
	$LevelSelect.popup()


func _on_SettingsButton_pressed():
	$Title.visible = false
	$Options.visible = false
	$Settings.popup()


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_Settings_popup_hide():
	$Title.visible = true
	$Options.visible = true
	$Options/NewGameButton.grab_focus()


func _on_LevelSelect_popup_hide():
	$Title.visible = true
	$Options.visible = true
	$Options/NewGameButton.grab_focus()
