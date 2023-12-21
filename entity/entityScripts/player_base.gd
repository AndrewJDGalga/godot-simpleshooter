extends Entity

class_name Player

@export var laser_fire_timelimit = 3.0
var missile_targeting:RayCast2D = null
var laser:RayCast2D = null

func _ready():
	missile_targeting = $missile_targeting
	laser = $player_laser

func laserHandler():
	if Input.is_action_just_pressed("fire_laser"):
		laser.enableLaser()
	if Input.is_action_just_released("fire_laser"):
		laser.disableLaser()
