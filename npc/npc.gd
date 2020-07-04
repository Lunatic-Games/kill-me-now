extends Node2D

export(Array, String) var dialogue
export(Texture) var npc_texture

var showing_text = false

func _ready():
	$Sprite.texture = npc_texture
	$Dialogue.content = dialogue

func interact_enter():
	print("Entered NPC area")
	if !showing_text:
		$Dialogue._make_active()
		showing_text = true

func interact():
	if showing_text:
		$Dialogue._flip_page()
	
func interact_exit():
	print("Exited NPC area")
	if showing_text:
		$Dialogue._make_inactive()
		showing_text = false
