extends Node2D

@export var target_positions:PackedVector2Array

@export var test_enemy:PackedScene = null


func get_random_target()->Vector2:
	return target_positions[randi() % target_positions.size()-1]

func add_enemy(manager:Node2D, level:int):
	var instance = test_enemy.instantiate()
	instance.destination_set(get_random_target())
	manager.call_deferred("add_child", instance)
