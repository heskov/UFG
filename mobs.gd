extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = false
var speed = 100
var player: Node2D
@onready var anim = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = Vector2.ZERO  # Объявляем direction перед использованием

	# Двигаем врага только если включена погоня
	if chase and player:
		direction = player_position()
		if direction != Vector2.ZERO:
			velocity.x = direction.x * speed
			anim.play('run')
	else:
		velocity.x = 0  
		anim.play('default')

	# Проверяем направление движения перед флипом спрайта
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

	move_and_slide()


func player_position() -> Vector2:
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		var player = players[0] as Node2D
		if chase:  # Добавляем проверку chase перед вычислением направления
			return (player.global_position - global_position).normalized()
	return Vector2.ZERO


func _on_detector_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		
		print(123)
		chase = true
		player = area.get_parent()	


func _on_detector_area_exited(area: Area2D) -> void:	
	if area.is_in_group("player"):
		print(321)
		chase = false
		player = null
