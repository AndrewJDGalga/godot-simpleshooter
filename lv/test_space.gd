extends Node2D

@onready var summon_timer = $summon_timer
@export var summon_dist_y:float = 40.0
@export var summon_dist_x:float = 80.0
var summon_square:Vector2

func _ready():
	summon_square = Vector2( \
		ProjectSettings.get_setting("display/window/size/viewport_width") + summon_dist_x, \
		ProjectSettings.get_setting("display/window/size/viewport_height") + summon_dist_y)


