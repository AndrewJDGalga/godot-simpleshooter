extends ColorRect

@export var max_fill:int = 32
var current_fill:int = 0

var filling = false

func increaseFill(dt):
	if current_fill < max_fill:
		changeFill(100 * dt)

func decreaseFill(dt):
	if current_fill > 0:
		changeFill(-100 * dt)

func changeFill(amt):
	current_fill += amt
	self.size.x = current_fill

func _process(delta):
	if filling:
		increaseFill(delta)
	else:
		decreaseFill(delta)

func _input(event):
	if event and event.is_action("fire_laser"):
		filling = true
	if event and event.is_action_released("fire_laser"):
		filling = false
