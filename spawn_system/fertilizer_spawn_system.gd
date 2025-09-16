extends Node

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
			node.fert_res = common_fertilizer_resource
		GLOBALS.rarity.rare:
			node.fert_res = rare_fertilizer_resource
		GLOBALS.rarity.ultra_rare:
			node.fert_res = ultra_rare_fertilizer_resource
	
	node.prepare_item()
	node.global_position = new_global_position
	node.z_index = 5

func delayed_fertilizer_spawn(new_global_position : Vector2, rarity : GLOBALS.rarity):
	call_deferred("spawn_fertilizer", new_global_position, rarity)
