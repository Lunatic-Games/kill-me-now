extends KinematicBody2D


const SPEED_ACCELERATION = 25
const SPEED_MAX = 150
const NUM_JUMPS = 2
const GRAVITY = 8
const GRAVITY_CAP = 800
const UP_DIRECTION = Vector2(0,-1)
const JUMP_SPEED = 250

var jumps_used = 0
var velocity = Vector2(0, 0)


func _physics_process(delta):
	if has_node("Soul"):
		if Input.is_action_just_pressed("move_down"):
			release_soul()
			return
		
		if Input.is_action_just_pressed("interact"):
			interact()
		
		var movement = Vector2(0, 0)
		if Input.is_action_pressed("move_left"):
			movement.x -= 1
			set_direction(-1)
		if Input.is_action_pressed("move_right"):
			movement.x += 1
			set_direction(1)
		if (Input.is_action_just_pressed("jump") or 
				Input.is_action_just_pressed("move_up") and jumps_used < NUM_JUMPS):
			jumps_used += 1
			velocity.y = -JUMP_SPEED
		
		velocity += movement * SPEED_ACCELERATION
		velocity.x = clamp(velocity.x, -SPEED_MAX, SPEED_MAX)

	
	if is_on_floor():
		jumps_used = 0
	else:
		velocity.y = min(velocity.y + GRAVITY, GRAVITY_CAP)
	if is_on_ceiling():
		velocity.y = max(0, velocity.y)
	velocity = move_and_slide(velocity, UP_DIRECTION)
	velocity.x = lerp(velocity.x, 0, 0.2)


func release_soul():
	var soul = get_node("Soul")
	var pos = soul.global_position
	remove_child(soul)
	get_parent().add_child(soul)
	soul.global_position = pos
	soul.free_from_body()
	

func interact():
	for area in $InteractArea.get_overlapping_areas():
		if area.is_in_group("interactable") and area.get_parent().has_method("interact"):
			area.get_parent().interact()


func set_direction(dir_sign):
	if has_node("Soul"):
		get_node("Soul").set_direction(dir_sign)
	
	$BodySprite.scale.x = dir_sign * abs($BodySprite.scale.x)
	$BodyCollisionShape2D.scale.x = dir_sign * abs($BodyCollisionShape2D.scale.x)
	$ReattachmentArea.scale.x = dir_sign * abs($ReattachmentArea.scale.x)


func _on_InteractArea_area_entered(area):
	if area.is_in_group("interactable") and area.get_parent().has_method("interact_enter"):
		area.get_parent().interact_enter()


func _on_InteractArea_area_exited(area):
	if area.is_in_group("interactable") and area.get_parent().has_method("interact_exit"):
		area.get_parent().interact_exit()
