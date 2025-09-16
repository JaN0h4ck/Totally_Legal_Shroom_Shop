extends Node

@onready var pickable_object_scene := preload("res://PickUpSystem/pickable_object.tscn")
@onready var common_fertilizer_resource := preload("res://PickUpSystem/fertilizer/common_fertilizer.tres")
@onready var rare_fertilizer_resource := preload("res://PickUpSystem/fertilizer/rare_fertilizer.tres")
@onready var ultra_rare_fertilizer_resource := preload("res://PickUpSystem/fertilizer/ultra_rare_fertilizer.tres")

func _ready():
	EventBus.spawn_fertilizer.connect(delayed_fertilizer_spawn)

func spawn_fertilizer(new_global_position : Vector2, rarity : GLOBALS.rarity):
	var node : PickableFertilizer = PickableFertilizer.new()
	add_child(node)
	match rarity:
		GLOBALS.rarity.common:
			node.selected_object = common_fertilizer_resource
		GLOBALS.rarity.rare:
			node.selected_object = rare_fertilizer_resource
		GLOBALS.rarity.ultra_rare:
			node.selected_object = ultra_rare_fertilizer_resource
	
	node.prepare_item()
	node.global_position = new_global_position
	#print("created", scene)

func delayed_fertilizer_spawn(new_global_position : Vector2, rarity : GLOBALS.rarity):
	call_deferred("spawn_fertilizer", new_global_position, rarity)
