extends Node

@onready var pickable_object_scene := preload("res://pick_up_system/pickable_object.tscn")
@onready var common_fertilizer_resource := preload("res://pick_up_system/fertilizer/common_fertilizer.tres")
@onready var rare_fertilizer_resource := preload("res://pick_up_system/fertilizer/rare_fertilizer.tres")
@onready var ultra_rare_fertilizer_resource := preload("res://pick_up_system/fertilizer/ultra_rare_fertilizer.tres")

func _ready():
	EventBus.spawn_fertilizer.connect(delayed_fertilizer_spawn)

func spawn_fertilizer(new_global_position : Vector2, rarity : pickable_object_resource.rarity_enum):
	var scene : pickable_object = pickable_object_scene.instantiate()
	#call_deferred("add_child", scene)
	add_child(scene)
	match rarity:
		pickable_object_resource.rarity_enum.common:
			scene.selected_object = common_fertilizer_resource
		pickable_object_resource.rarity_enum.rare:
			scene.selected_object = rare_fertilizer_resource
		pickable_object_resource.rarity_enum.ultra_rare:
			scene.selected_object = ultra_rare_fertilizer_resource
	
	scene.create_fertilizer()
	scene.global_position = new_global_position
	#print("created", scene)

func delayed_fertilizer_spawn(new_global_position : Vector2, rarity : pickable_object_resource.rarity_enum):
	call_deferred("spawn_fertilizer", new_global_position, rarity)
