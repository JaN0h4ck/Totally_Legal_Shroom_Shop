extends Node2D

@onready var pickable_object_scene := preload("res://PickUpSystem/pickable_object.tscn")
@onready var corpse_resource_alien := preload("res://PickUpSystem/corpse/alien_corpse.tres")
@onready var corpse_resource_angry := preload("res://PickUpSystem/corpse/angry_corpse.tres")
@onready var corpse_resource_beff := preload("res://PickUpSystem/corpse/beff_corpse.tres")
@onready var corpse_resource_celeb := preload("res://PickUpSystem/corpse/celeb_corpse.tres")
@onready var corpse_resource_conspiracy := preload("res://PickUpSystem/corpse/conspiracy_corpse.tres")
@onready var corpse_resource_cook := preload("res://PickUpSystem/corpse/cook_corpse.tres")
@onready var corpse_resource_cowboy := preload("res://PickUpSystem/corpse/cowboy_corpse.tres")
@onready var corpse_resource_enthusiast := preload("res://PickUpSystem/corpse/enthusiast_corpse.tres")
@onready var corpse_resource_grandpa := preload("res://PickUpSystem/corpse/grandpa_corpse.tres")
@onready var corpse_resource_nerd := preload("res://PickUpSystem/corpse/nerd_corpse.tres")

func _ready():
	EventBus.npc_dropped.connect(spawn_corpse)

# Aktuell Verfügbare Leichen alien, angry, beff, celeb, conspiracy, cook, cowboy, enthusiast, nerd, grandpa
func spawn_corpse(corpse_name : base_npc.npc_name_enum):
	var scene : pickable_object = pickable_object_scene.instantiate()
	add_child(scene)
	match corpse_name:
		base_npc.npc_name_enum.alien:
			scene.selected_object = corpse_resource_alien
		base_npc.npc_name_enum.angry:
			scene.selected_object = corpse_resource_angry
		base_npc.npc_name_enum.beff:
			scene.selected_object = corpse_resource_beff
		base_npc.npc_name_enum.celeb:
			scene.selected_object = corpse_resource_celeb
		base_npc.npc_name_enum.conspiracy:
			scene.selected_object = corpse_resource_conspiracy
		base_npc.npc_name_enum.cook:
			scene.selected_object = corpse_resource_cook
		base_npc.npc_name_enum.cowboy:
			scene.selected_object = corpse_resource_cowboy
		base_npc.npc_name_enum.enthusiast:
			scene.selected_object = corpse_resource_enthusiast
		base_npc.npc_name_enum.nerd:
			scene.selected_object = corpse_resource_nerd
		base_npc.npc_name_enum.opa:
			scene.selected_object = corpse_resource_grandpa
	
	scene.create_corpse()
