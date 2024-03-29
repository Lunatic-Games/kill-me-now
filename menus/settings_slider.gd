extends HBoxContainer

const SLIDE_SPEED = 100
const SLIDE_JUMP = 5

var held = false


# Move sliders if held
func _process(delta):
	if held:
		if Input.is_action_pressed("ui_right"):
			$MarginContainer/Slider.value += SLIDE_SPEED * delta
		if Input.is_action_pressed("ui_left"):
			$MarginContainer/Slider.value -= SLIDE_SPEED * delta


# Highlight label when slider is focused
func _on_Slider_focus_entered():
	$Label.pressed = true


# Remove highlighting of label when slider focus is removed
func _on_Slider_focus_exited():
	$Label.pressed = false
	$Label/UnfocusSFX.play()
	$HoldTimer.stop()
	held = false


# Move slider when ui_left or ui_right is pressed
func _on_Slider_gui_input(_event):
	if Input.is_action_just_pressed("ui_right") and $HoldTimer.is_stopped():
		$HoldTimer.start()
		$MarginContainer/Slider.value += SLIDE_JUMP
		$Label/UnfocusSFX.play()
	if Input.is_action_just_pressed("ui_left") and $HoldTimer.is_stopped():
		$HoldTimer.start()
		$MarginContainer/Slider.value -= SLIDE_JUMP
		$Label/UnfocusSFX.play()

	if (Input.is_action_just_released("ui_left") 
			and !Input.is_action_pressed("ui_right")):
		$HoldTimer.stop()
		held = false
	if (Input.is_action_just_released("ui_right") 
			and !Input.is_action_pressed("ui_left")):
		$HoldTimer.stop()
		held = false


# Count as being held after set time
func _on_HoldTimer_timeout():
	held = true
