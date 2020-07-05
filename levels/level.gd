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
	get_tree().change_scene_to(next_level)


func _unhandled_input(event):
	if event.is_action_pressed("pause") and !$PauseMenu.visible:
		get_tree().paused = true
		$PauseMenu.popup()
		get_tree().set_input_as_handled()
