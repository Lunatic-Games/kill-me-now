extends KinematicBody2D


const SPEED_ACCELERATION = 15
const SPEED_MAX = 100
const RELEASE_VELOCITY = 300

var is_free = false
var can_reattach = false
var velocity = Vector2(0, 0)


func _ready():
	if get_tree().current_scene == self:
		free_from_body()


func _physics_process(delta):
	if !is_free:
		return
	
	var movement = Vector2()
	
	if Input.is_action_pressed("move_up"):
		movement.y -= 1
	if Input.is_action_pressed("move_right"):
		movement.x += 1
		set_direction(1)
	if Input.is_action_pressed("move_down"):
		movement.y += 1
	if Input.is_action_pressed("move_left"):
		movement.x -= 1
		set_direction(-1)
	
	if velocity.length() < SPEED_MAX:
		velocity += movement * SPEED_ACCELERATION
		velocity = velocity.clamped(SPEED_MAX)
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2(0, 0), 0.1)


func free_from_body():
	is_free = true
	$Particles2D.emitting = true
	velocity.x = sign($Sprite.scale.x) * RELEASE_VELOCITY
	$ReattachCooldown.start()


func attach_to_body(body):
	is_free = false
	can_reattach = false
	$Particles2D.emitting = false
	get_parent().remove_child(self)
	body.add_child(self)
	body.move_child(self, 0)
	body.set_direction(sign($Sprite.scale.x))
	position = body.get_node("AttachmentPoint").position


func _on_AttachmentArea_area_entered(area):
	if area.name == "ReattachmentArea" and is_free and can_reattach:
		call_deferred("attach_to_body", area.get_parent())


func _on_ReattachCooldown_timeout():
	can_reattach = true


func set_direction(dir_sign):
	$Sprite.scale.x = dir_sign * abs($Sprite.scale.x)
	$CollisionShape2D.scale.x = dir_sign * abs($CollisionShape2D.scale.x)
	$AttachmentArea.scale.x = dir_sign * abs($AttachmentArea.scale.x)
