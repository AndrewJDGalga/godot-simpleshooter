extends ColorRect

@export var max_fill:int = 32
#var fill_rate:float = 100 : set = set_fill_rate
var current_fill:float = 0

#func set_fill_rate(val):
	#fill_rate = val

func increaseFill(dt, fill):
	if current_fill < max_fill:
		changeFill(fill, dt)

func decreaseFill(dt, fill):
	if current_fill > 0:
		changeFill(-fill, dt)

func changeFill(amt, dt):
	current_fill += amt * dt
	print(current_fill)
	self.size.x = current_fill

func is_overheated():
	return current_fill >= max_fill

func is_cool():
	return current_fill <= 0 


#func reset_fill():
	#changeFill(0)
