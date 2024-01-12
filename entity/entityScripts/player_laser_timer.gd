extends ColorRect

@onready var acc_back = $AccuracyBacking
@export var max_fill:int = 50
var current_fill:float = 0
var current_fill_color:float = 1.0

func increaseFill(dt, fill):
	if current_fill < max_fill:
		changeFill(fill, dt)
	changeColor(-0.2,dt)

func decreaseFill(dt, fill):
	if current_fill > 0:
		changeFill(-fill, dt)
	changeColor(0.2,dt)

func changeFill(amt, dt):
	current_fill += amt * dt
	self.size.x = current_fill

#func _process(delta):
	#changeColor(-0.2,delta)
	#print(self.color)

func changeColor(change, dt):
	if current_fill_color <= 1.0 && current_fill_color > 0.0:
		current_fill_color += change * dt
	if current_fill_color < 0.0:
		current_fill_color = 0.0
	self.color = Color(1.0, current_fill_color, current_fill_color)

func is_overheated():
	return current_fill >= max_fill

func is_cool():
	return current_fill <= 0 

