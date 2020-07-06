extends "res://levels/level.gd"



func _on_Touchdown_area_entered(area):
	if area.name == "InteractArea":
		$Body.set_physics_process(false)
		$Body.set_process_input(false)
		$Body/AnimationPlayer.play("idle")
		$Body/Soul.position = Vector2(0, 4)
		set_process_unhandled_input(false)
		$AnimationPlayer.play("end_sequence")


func end():
	LevelsComplete.level_completed("7")
	var _err = get_tree().change_scene("res://menus/main_menu/main_menu.tscn")
