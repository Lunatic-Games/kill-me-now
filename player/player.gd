extends KinematicBody2D


var mode_changed = false

var motion = Vector2()
var facing_right = true
const BODY_SPEED = 175
const SOUL_SPEED = 200

var remaining_jumps = 0
const JUMP_SPEED = 250
const NUM_JUMPS = 1

const GRAVITY_RATE = 8
const GRAVITY_CAP = 800
const UP_DIRECTION = Vector2(0,-1)

func _physics_process(delta):
	if has_node("Soul"):
		if Input.is_action_just_pressed("action_soul_mode") && is_on_floor():
			release_soul()
			return
		if !is_on_floor():
			if motion.y < GRAVITY_CAP:
				motion.y += GRAVITY_RATE
				if motion.y > GRAVITY_CAP:
					motion.y = GRAVITY_CAP
		if Input.is_action_just_pressed("ui_right"):
			motion.x  += BODY_SPEED # TODO Accelerate to speed
			mode_changed = false
			face_direction("right")
		if Input.is_action_just_pressed("ui_left"):
			motion.x -= BODY_SPEED # TODO Accelerate to speed
			mode_changed = false
			face_direction("left")
		if Input.is_action_just_released("ui_right") && !mode_changed:
			motion.x -= BODY_SPEED # TODO Accelerate to speed
		if Input.is_action_just_released("ui_left") && !mode_changed:
			motion.x += BODY_SPEED # TODO Accelerate to speed
		if Input.is_action_just_pressed("action_jump") && !is_on_ceiling() && remaining_jumps > 0:
			motion.y = -JUMP_SPEED
			remaining_jumps -= 1
		if is_on_ceiling():
			motion.y = 1
		if is_on_floor():
			remaining_jumps = NUM_JUMPS
		move_and_slide(motion, UP_DIRECTION)


func release_soul():
	motion = Vector2()
	var soul = get_node("Soul")
	var pos = soul.global_position
	remove_child(soul)
	get_parent().add_child(soul)
	soul.global_position = pos
	soul.free = true
	soul.velocity = Vector2(2000, 0)


func face_direction(direction):
	if direction == "right":
		if !facing_right:
			scale.x = -1
			facing_right = true
		return
	if direction == "left":
		if facing_right:
			scale.x = -1
			facing_right = false
		return
