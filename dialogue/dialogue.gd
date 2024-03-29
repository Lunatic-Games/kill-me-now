extends Node2D

export (Array, String) var content
var page = 0
var feed = ""
var text = ""
const DEFAULT_DIALOGUE = ["THIS NPC HAS NO DIALOGUE"]


func _ready():
	visible = false
	if !content:
		content = DEFAULT_DIALOGUE

func _make_active():
	visible = true
	page = 0
	feed = content[page]
	$Timer.start()

func _make_inactive():
	visible = false
	text = ""
	feed = ""
	$Label.text = ""
	$Timer.stop()

func _flip_page():
	if page < content.size() - 1:
		page += 1
		text += feed + "\n"
		feed = content[page]
	else:
		if feed.empty():
			if visible:
				_make_inactive()
			else:
				_make_active()
		else:
			text += feed
			feed = ""
			$Label.text = text

func _on_timeout():
	if !feed.empty():
		text += feed[0]
		feed.erase(0,1)
		if !feed.empty():
			if feed[0] == " ":
				text += feed[0]
				feed.erase(0,1)
	$Label.text = text
