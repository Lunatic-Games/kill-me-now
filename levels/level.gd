extends Node2D


export (PackedScene) var next_level


func _ready():
	for body in get_tree().get_nodes_in_group("body"):
		body.connect("soul_died", self, "_on_Body_soul_died")


func _on_Body_soul_died():
	if !next_level:
		print("No next level")
		return
	yield(get_tree().create_timer(1.0), "timeout")
	var _err = get_tree().change_scene_to(next_level)


func _unhandled_input(event):
	if event.is_action_pressed("pause") and !$CanvasLayer/PauseMenu.visible:
		get_tree().paused = true
		$CanvasLayer/PauseMenu.popup_centered(Vector2(1024, 576))
		get_tree().set_input_as_handled()
