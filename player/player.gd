extends KinematicBody2D

export(Texture) var SOUL_TEXTURE
export(Texture) var body_texture

var soul_mode = false
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
	if !soul_mode:
		if Input.is_action_just_pressed("action_soul_mode") && is_on_floor():
			toggle_soul_mode()
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

	if soul_mode:
		# TODO Soul gravity
		if Input.is_action_just_pressed("action_soul_mode"):
			toggle_soul_mode()
			return
		if Input.is_action_just_pressed("ui_right"):
			motion.x += SOUL_SPEED
			mode_changed = false
			face_direction("right")
		if Input.is_action_just_pressed("ui_left"):
			motion.x -= SOUL_SPEED
			mode_changed = false
			face_direction("left")
		if Input.is_action_just_pressed("ui_up"):
			motion.y -= SOUL_SPEED
			mode_changed = false
		if Input.is_action_just_pressed("ui_down"):
			motion.y += SOUL_SPEED
			mode_changed = false
		if Input.is_action_just_released("ui_right") && !mode_changed:
			motion.x -= SOUL_SPEED
		if Input.is_action_just_released("ui_left") && !mode_changed:
			motion.x += SOUL_SPEED
		if Input.is_action_just_released("ui_up") && !mode_changed:
			motion.y += SOUL_SPEED
		if Input.is_action_just_released("ui_down") && !mode_changed:
			motion.y -= SOUL_SPEED
		move_and_slide(motion)

func toggle_soul_mode():
	soul_mode = !soul_mode
	mode_changed = true
	motion = Vector2()
	if soul_mode:
		print("Entered soul mode")
	if !soul_mode:
		print("Left soul mode")
		
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
