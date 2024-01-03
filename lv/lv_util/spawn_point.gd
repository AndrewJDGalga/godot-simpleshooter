extends Node2D

@export var facing_direction:Vector2

@export var test_enemy:PackedScene = null


#func get_random_target()->Vector2:
	#return target_positions[randi() % target_positions.size()-1]

func add_enemy(manager:Node2D, level:int):
	var instance = test_enemy.instantiate()
	instance.destination_set(facing_direction)
	manager.call_deferred("add_child", instance)
