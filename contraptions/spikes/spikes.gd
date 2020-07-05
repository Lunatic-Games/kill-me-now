extends Area2D



func _on_Spikes_area_entered(area):
	if area.name == "Feet":
		area.get_parent().kill()
