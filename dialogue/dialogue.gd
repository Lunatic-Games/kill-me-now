extends Node2D

var content
var page = 0
const DEFAULT_DIALOGUE = ["THIS NPC HAS NO DIALOGUE"]


func _ready():
	visible = false
	if !content:
		content = DEFAULT_DIALOGUE

func _make_active():
	visible = true
	page = 0
	$Label.text = content[page]

func _make_inactive():
	visible = false

func _flip_page():
	if page < content.size() - 1:
		page += 1
		$Label.text = content[page]
	else:
		_make_inactive()
