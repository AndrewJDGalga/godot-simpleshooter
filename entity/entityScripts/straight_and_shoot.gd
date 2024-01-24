extends Enemy

@export var move_direction: Vector2 = Vector2(1,0)

func _physics_process(delta):
	position += move_direction * delta * move_speed

