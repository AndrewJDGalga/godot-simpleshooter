extends Node2D

@onready var spawn_point = $SpawnPoint

func _ready():
	spawn_point.add_enemy(self, 1) 
