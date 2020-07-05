extends KinematicBody2D


const GRAVITY = 6
const GRAVITY_CAP = 800

var velocity = Vector2(0, 0)


func _physics_process(delta):
	velocity.y = min(velocity.y + GRAVITY, GRAVITY_CAP)
	var prev_y_vel = velocity.y
	velocity = move_and_slide(velocity, Vector2(0, -1))
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.normal == Vector2(0, -1) and prev_y_vel > 10:
			var hit = collision.collider
			if hit.is_in_group("body"):
				hit.kill()
