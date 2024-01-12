extends RayCast2D

@onready var sprite = $ColorRect

func _ready():
	set_laser_active(false)

func set_laser_active(boolean):
	sprite.visible = boolean
	self.enabled = boolean

func enable_laser():
	set_laser_active(true)

func disable_laser():
	set_laser_active(false)
