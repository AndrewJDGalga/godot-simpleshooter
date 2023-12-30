extends Node2D

@onready var summon_timer = $summon_timer
@export var summon_dist_y:float = 40.0
@export var summon_dist_x:float = 80.0

@export var test_enemy_ref:PackedScene = null

var summon_square:Vector2

func _ready():
	summon_square = Vector2( \
		ProjectSettings.get_setting("display/window/size/viewport_width") + summon_dist_x, \
		ProjectSettings.get_setting("display/window/size/viewport_height") + summon_dist_y)
	
	var test_enemy = test_enemy_ref.instantiate()
	test_enemy.destination_set(Vector2(20,20))
	call_deferred("add_child", test_enemy)

