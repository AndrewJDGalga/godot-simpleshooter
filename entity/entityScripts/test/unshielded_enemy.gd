extends "res://entity/entityScripts/entity.gd"

@export var direction:Vector2 = Vector2.ZERO
@export var reverse_wave := false

var freq = 1.0
var amp = 200.0
var time = 0
var wave_effect := 0

func _ready():
	if reverse_wave:
		amp *= -1
	print(get_tree().root.get_child_count())

func _physics_process(delta):
	if direction != Vector2.ZERO:
		time += delta
		wave_effect = cos(time * freq) * amp
		velocity = Vector2(move_speed * direction.x, wave_effect)
	move_and_slide()

