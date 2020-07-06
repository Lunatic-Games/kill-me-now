extends Node


var levels = ["0"]


func level_completed(name):
	if levels.has(name):
		return
	levels.append(name)
