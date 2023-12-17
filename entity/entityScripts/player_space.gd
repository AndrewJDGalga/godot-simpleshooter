extends Player

func _physics_process(delta):
	var dir = Vector2(Input.get_action_strength("right") - \
	Input.get_action_strength("left"), Input.get_action_strength("down") - \
	Input.get_action_strength("up"))
	velocity = move_speed * dir * delta
	move_and_collide(velocity)
	
	if Input.is_action_pressed("fire_laser"):
		pass
	
	if Input.is_action_just_pressed("fire_missile"):
		pass

