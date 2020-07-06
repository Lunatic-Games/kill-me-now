extends Button



func _on_MenuButton_focus_exited():
	if !$UnfocusSFX.playing:
		$UnfocusSFX.play()


func _on_MenuButton_pressed():
	if !$UnfocusSFX.playing:
		$UnfocusSFX.play()
