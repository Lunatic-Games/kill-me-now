extends Area2D


export (bool) var on = true


func _ready():
	if on:
		turn_on()
	else:
		turn_off()


func turn_on():
	on = true
	$Sprite/AnimationPlayer.play("on")


func turn_off():
	on = false
	$Sprite/AnimationPlayer.play("off")


func _on_ElectricRail_area_entered(area):
	if area.name == "Feet" and on:
		area.get_parent().kill()
