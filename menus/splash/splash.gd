extends VideoPlayer


const main_menu = preload("res://menus/main_menu/main_menu.tscn")


func _input(event):
	if event.is_action_pressed("ui_accept"):
		_on_Splash_finished()
		


func _on_Splash_finished():
	var _err = get_tree().change_scene_to(main_menu)
