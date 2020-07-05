extends Node2D


func open():
	$AnimationPlayer.play("open")


func close():
	$AnimationPlayer.play_backwards("open")
