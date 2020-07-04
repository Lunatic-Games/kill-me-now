extends KinematicBody2D

var soul_mode = false

var motion = Vector2()
const SPEED = 175

var remaining_jumps = 0
const JUMP_SPEED = 250
const NUM_JUMPS = 1

const GRAVITY_RATE = 8
const GRAVITY_CAP = 800
const UP_DIRECTION = Vector2(0,-1)

func _physics_process(delta):
	if Input.is_action_just_pressed("action_soul_mode"):
		toggle_soul_mode()
	if !soul_mode:
		if !is_on_floor():
			if motion.y < GRAVITY_CAP:
				motion.y += GRAVITY_RATE
				if motion.y > GRAVITY_CAP:
					motion.y = GRAVITY_CAP
		if Input.is_action_just_pressed("ui_right"):	
			motion.x  += SPEED # TODO Accelerate to speed
		if Input.is_action_just_pressed("ui_left"):
			motion.x -= SPEED # TODO Accelerate to speed
		if Input.is_action_just_released("ui_right"):
			motion.x -= SPEED # TODO Accelerate to speed
		if Input.is_action_just_released("ui_left"):
			motion.x += SPEED # TODO Accelerate to speed
		if Input.is_action_just_pressed("action_jump") && !is_on_ceiling() && remaining_jumps > 0:
			motion.y = -JUMP_SPEED
			remaining_jumps -= 1
		if is_on_ceiling():
			motion.y = 1
		if is_on_floor():
			remaining_jumps = NUM_JUMPS

		move_and_slide(motion, UP_DIRECTION)

func toggle_soul_mode():
	soul_mode = !soul_mode
	motion = Vector2()
	if soul_mode:
		print("Entered soul mode")
	if !soul_mode:
		print("Left soul mode")
