extends "res://entity/entityScripts/entity.gd"

var destination: get = destination_get, set = destination_set
var direction:Vector2 = Vector2.ZERO

func _ready():
	direction = Vector2(position.x - destination.x, position.y - destination.y).normalized() 

func _physics_process(delta):
	pass

func destination_get():
	return destination

func destination_set(val:Vector2):
	destination = val
