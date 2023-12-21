extends RayCast2D

var sprite = null

func _ready():
	sprite = $ColorRect
	setLaserActive(false)

func setLaserActive(boolean):
	sprite.visible = boolean
	self.enabled = boolean

func enableLaser():
	setLaserActive(true)

func disableLaser():
	setLaserActive(false)
