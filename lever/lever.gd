signal lever_pull

extends Node2D

var direction = -1

func interact():
	if direction > 0:
		direction = -1
	else:
		direction = 1
	$Sprite.scale.x = direction
	emit_signal("lever_pull")
