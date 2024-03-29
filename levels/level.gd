extends Node2D


export (PackedScene) var next_level
export (int) var level_number = 0

const music_scene = preload("res://levels/level_music.tscn")


func _ready():
	for body in get_tree().get_nodes_in_group("body"):
		body.connect("soul_died", self, "_on_Body_soul_died")
	if !get_tree().root.has_node("Music"):
		var music = music_scene.instance()
		get_tree().root.call_deferred("add_child", music)


func _on_Body_soul_died():
	if !next_level:
		print("No next level")
		return
	yield(get_tree().create_timer(1.0), "timeout")
	LevelsComplete.level_completed(str(level_number))
	var _err = get_tree().change_scene_to(next_level)


func _unhandled_input(event):
	if event.is_action_pressed("pause") and !$CanvasLayer/PauseMenu.visible:
		get_tree().paused = true
		$CanvasLayer/PauseMenu.popup_centered(Vector2(1024, 576))
		get_tree().set_input_as_handled()
	if event.is_action_pressed("restart"):
		var _err = get_tree().reload_current_scene()
