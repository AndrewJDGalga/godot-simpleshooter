extends CharacterBody2D

class_name Player

@export var move_speed:float = 50
@export var base_health:int = 1
@export var base_shield:int = 3
var missile_targeting:RayCast2D = null

func _ready():
	missile_targeting = $missile_targeting
