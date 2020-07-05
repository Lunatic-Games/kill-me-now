extends Node2D


func _ready():
	yield(get_tree().create_timer(2), "timeout")
	$Dialogue._make_active()
	yield(get_tree().create_timer(1), "timeout")
	$Dialogue._flip_page()
	yield(get_tree().create_timer(4), "timeout")
	$Dialogue._flip_page()
	yield(get_tree().create_timer(4), "timeout")
	$Dialogue._flip_page()
	yield(get_tree().create_timer(1.5), "timeout")
	$Crash/AnimationPlayer.play("crash")
