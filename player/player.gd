extends KinematicBody2D

var motion = Vector2()
const SPEED = 150
const JUMP_SPEED = 200
const GRAVITY_RATE = 5
const GRAVITY_CAP = 800

func _physics_process(delta):
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
	if Input.is_action_just_pressed("jump_action"):
		motion.y = -JUMP_SPEED
	move_and_slide(motion)

