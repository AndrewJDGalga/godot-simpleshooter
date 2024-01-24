extends Area2D

class_name Enemy

@export var move_speed := 20.0
var target:CharacterBody2D = null

func _ready():
	print(get_tree().root.get_child(0).get_player().name)
	print(get_tree().get_current_scene().get_player().name)

