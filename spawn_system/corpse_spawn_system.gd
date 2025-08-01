extends Node2D

@onready var pickable_object_scene := preload("res://pick_up_system/pickable_object.tscn")
@onready var corpse_resource_alien := preload("res://pick_up_system/corpses/alien_corpse.tres")

func _ready():
	EventBus.npc_dropped.connect(spawn_corpse2)

# Aktuell Verfügbare Leichen alien, angry, beff, celeb, conspiracy, cook, cowboy, enthusiast, nerd, opa

func spawn_corpse(corpse_name : base_npc.npc_name_enum):
	var corpse : pickable_object = pickable_object.new()
	add_child(corpse)
	match corpse_name:
		base_npc.npc_name_enum.alien:
			corpse.selected_object = corpse_resource_alien
		_:
			corpse.selected_object = corpse_resource_alien
	
	corpse.create_corpse()

func spawn_corpse2(corpse_name : base_npc.npc_name_enum):
	var scene : pickable_object = pickable_object_scene.instantiate()
	add_child(scene)
	match corpse_name:
		base_npc.npc_name_enum.alien:
			scene.selected_object = corpse_resource_alien
		base_npc.npc_name_enum.angry:
			scene.selected_object = corpse_resource_alien
		base_npc.npc_name_enum.beff:
			scene.selected_object = corpse_resource_alien
		base_npc.npc_name_enum.celeb:
			scene.selected_object = corpse_resource_alien
		base_npc.npc_name_enum.conspiracy:
			scene.selected_object = corpse_resource_alien
		base_npc.npc_name_enum.cook:
			scene.selected_object = corpse_resource_alien
		base_npc.npc_name_enum.cowboy:
			scene.selected_object = corpse_resource_alien
		base_npc.npc_name_enum.enthusiast:
			scene.selected_object = corpse_resource_alien
		base_npc.npc_name_enum.nerd:
			scene.selected_object = corpse_resource_alien
		base_npc.npc_name_enum.opa:
			scene.selected_object = corpse_resource_alien
	
	scene.create_corpse()
