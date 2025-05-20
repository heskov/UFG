extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -320.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D2.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			$AnimatedSprite2D2.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			$AnimatedSprite2D2.play("idle")
	if direction == -1:
		$AnimatedSprite2D2.flip_h = true
	elif direction == 1:
		$AnimatedSprite2D2.flip_h = false
	if velocity.y >0:
		$AnimatedSprite2D2.play("fall")
	move_and_slide()
