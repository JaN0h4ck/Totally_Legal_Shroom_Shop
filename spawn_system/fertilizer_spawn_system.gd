extends Node

@onready var pickable_object_scene := preload("res://PickUpSystem/pickable_object.tscn")
@onready var common_fertilizer_resource := preload("res://PickUpSystem/fertilizer/common_fertilizer.tres")
@onready var rare_fertilizer_resource := preload("res://PickUpSystem/fertilizer/rare_fertilizer.tres")
@onready var ultra_rare_fertilizer_resource := preload("res://PickUpSystem/fertilizer/ultra_rare_fertilizer.tres")

func _ready():
	EventBus.spawn_fertilizer.connect(delayed_fertilizer_spawn)

func spawn_fertilizer(new_global_position : Vector2, rarity : GLOBALS.rarity):
	var scene : pickable_object = pickable_object_scene.instantiate()
	#call_deferred("add_child", scene)
	add_child(scene)
	match rarity:
		GLOBALS.rarity.common:
			scene.selected_object = common_fertilizer_resource
		GLOBALS.rarity.rare:
			scene.selected_object = rare_fertilizer_resource
		GLOBALS.rarity.ultra_rare:
			scene.selected_object = ultra_rare_fertilizer_resource
	
	scene.create_fertilizer()
	scene.global_position = new_global_position
	#print("created", scene)

func delayed_fertilizer_spawn(new_global_position : Vector2, rarity : GLOBALS.rarity):
	call_deferred("spawn_fertilizer", new_global_position, rarity)
