extends Entity

class_name Player

@export var laser_fire_timelimit = 3.0
var missile_targeting:RayCast2D = null
var laser:RayCast2D = null

func _ready():
	missile_targeting = $missile_targeting
