extends Node2D

@onready var spawn_point = $spawn_points/SpawnPoint

func _ready():
	spawn_point.add_enemy(self, 1) 
