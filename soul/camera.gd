extends Camera2D


func _physics_process(delta):
	var soul = get_tree().get_nodes_in_group("soul")
	if !soul:
		return
	global_position = soul[0].global_position
	limit_top = -100000
	limit_right = 100000
	limit_bottom = 100000
	limit_left = -100000
	
	for area in $Area2D.get_overlapping_areas():
		if !area.is_in_group("camera_boundry"):
			continue
		var coll = area.get_node("CollisionShape2D")
		var size = coll.shape.extents
		var pos = coll.global_position
		var horizontal = size.x > size.y
		if horizontal:
			if pos.y < global_position.y:
				limit_top = max(pos.y + size.y / 2, limit_top)
			else:
				limit_bottom = min(pos.y - size.y / 2, limit_bottom)
		else:
			if pos.x > global_position.x:
				limit_right = min(pos.x - size.x / 2, limit_right)
			else:
				limit_left = max(pos.x + size.x / 2, limit_left)
