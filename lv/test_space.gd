extends Node2D

#@onready var summon_timer = $summon_timer
#@export var summon_dist_y:float = 40.0
#@export var summon_dist_x:float = 80.0
#
#@export var test_enemy_ref:PackedScene = null
#
#var summon_square:Vector2
#
#func _ready():
	#summon_square = Vector2( \
		#ProjectSettings.get_setting("display/window/size/viewport_width") + summon_dist_x, \
		#ProjectSettings.get_setting("display/window/size/viewport_height") + summon_dist_y)
	#print(intersect_perimeter(summon_square.x, summon_square.y,summon_square.x, summon_square.y))
	#var test_enemy = test_enemy_ref.instantiate()
	#test_enemy.destination_set(Vector2(20,20))
	#call_deferred("add_child", test_enemy)
#
#func get_perimeter_position(rect_obj:Vector2):
	#return 2 * (rect_obj.x + rect_obj.y)
#
#func intersect_perimeter(x, y, w, h):
	#if abs(y*w) > abs(x*h):
		#return Vector2(0.5*h*x/abs(y), 0.5*h*sign(y))
	#else:
		#return Vector2(0.5*w*sign(x), 0.5*w*y/abs(x))
#
#
#func _on_button_pressed():
	#pass # Replace with function body.
