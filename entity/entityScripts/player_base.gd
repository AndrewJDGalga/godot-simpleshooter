extends Entity

class_name Player

var missile_targeting:RayCast2D = null

func _ready():
	missile_targeting = $missile_targeting
