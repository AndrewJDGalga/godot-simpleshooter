extends Node2D

@export var target_positions:PackedVector2Array

@export var test_enemy:PackedScene = null

func get_random_target()->Vector2:
	#docs say this is safe
	return target_positions[randi() % target_positions.size()]
