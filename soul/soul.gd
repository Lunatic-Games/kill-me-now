extends KinematicBody2D


const SPEED_ACCELERATION = 15
const SPEED_MAX = 100

var free = false
var velocity = Vector2(0, 0)


func _ready():
	if get_tree().current_scene == self:
		free = true


func _physics_process(delta):
	if !free:
		return
	
	var movement = Vector2()
	
	if Input.is_action_pressed("move_up"):
		movement.y -= 1
	if Input.is_action_pressed("move_right"):
		movement.x += 1
	if Input.is_action_pressed("move_down"):
		movement.y += 1
	if Input.is_action_pressed("move_left"):
		movement.x -= 1
	
	velocity += movement * SPEED_ACCELERATION
	velocity = velocity.clamped(SPEED_MAX)
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2(0, 0), 0.1)
