extends Node
class_name mushroom_spawn_system

@onready var pickable_object_scene := preload("res://pick_up_system/pickable_object.tscn")
@onready var mushroom_resource_alien := preload("res://pick_up_system/mushroom/alien_mushroom.tres")

func spawn_mushroom_seed(location : Vector2):
	print("interacted at ", location)
