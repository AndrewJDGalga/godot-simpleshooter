extends ColorRect

@export var max_fill:int = 32
var current_fill:int = 0

func increaseFill():
	if current_fill < max_fill:
		changeFill(1)

func decreaseFill():
	if current_fill > 0:
		changeFill(-1)

func changeFill(amt):
	current_fill += amt
	self.size.x = current_fill


func _input(event):
	if event and event.is_action("fire_laser"):
		increaseFill()
	if event and event.is_action_released("fire_laser"):
		pass
