extends StaticBody2D


signal toggled


func _on_Area2D_area_entered(area):
	if area.name == "Feet":
		emit_signal("toggled", true)
		$AnimationPlayer.play("pressed")


func _on_Area2D_area_exited(area):
	if area.name == "Feet":
		emit_signal("toggled", false)
		$AnimationPlayer.play("released")
