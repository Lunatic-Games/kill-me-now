extends Popup


const NUMBER_OF_LEVELS = 25
const HIGHEST_COMPLETED = 13
const ButtonScene = preload("res://menus/menu_button.tscn")


func _ready():
	for i in range(NUMBER_OF_LEVELS):
		var new_button = ButtonScene.instance()
		new_button.text = str(i + 1)
		if i > HIGHEST_COMPLETED - 1:
			new_button.disabled = true
		$VBoxContainer/CenterContainer/GridContainer.add_child(new_button)


func _on_BackButton_pressed():
	hide()
