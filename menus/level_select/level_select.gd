extends Popup


const LEVELS = {
	"0": "res://levels/car_scene.tscn",
	"1": "res://levels/train_station_1.tscn",
	"2": "res://levels/train_station_2.tscn",
	"3": "res://levels/train_station_3.tscn",
	"4": "res://levels/train_station_4.tscn",
	"5": "res://levels/train_station_5.tscn",
	"6": "res://levels/dungeon_1.tscn",
	"7": "res://levels/end_scene.tscn"
}

const ButtonScene = preload("res://menus/menu_button.tscn")


func _ready():
	for i in LEVELS.keys().size():
		var new_button = ButtonScene.instance()
		new_button.text = str(i)
		if !LevelsComplete.levels.has(str(i)):
			new_button.disabled = true
		new_button.connect("pressed", self, "level_select", [str(i)])
		$VBoxContainer/CenterContainer/GridContainer.add_child(new_button)


func _on_BackButton_pressed():
	hide()


func level_select(name):
	var _err = get_tree().change_scene(LEVELS[name])
