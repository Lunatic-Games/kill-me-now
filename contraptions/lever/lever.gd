extends Node2D


signal pulled

var toggled = false


func interact():
	toggled = !toggled
	if toggled:
		$AnimationPlayer.play("flip_right")
		emit_signal("pulled", true)
	else:
		$AnimationPlayer.play("flip_left")
		emit_signal("pulled", false)
