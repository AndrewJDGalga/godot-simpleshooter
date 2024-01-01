extends "res://entity/entityScripts/entity.gd"

var destination: set = destination_set
var direction:Vector2 = Vector2.ZERO

var freq = 1.0
var amp = 200.0
var time = 0
var wave_effect := 0

func _ready():
	direction = Vector2(destination.x - position.x, destination.y - position.y).normalized()

func _physics_process(delta):
	if direction != Vector2.ZERO:
		pass
	time += delta
	wave_effect = cos(time * freq) * amp
	velocity = Vector2(move_speed, wave_effect)
	move_and_slide()

func destination_set(val:Vector2):
	destination = val
