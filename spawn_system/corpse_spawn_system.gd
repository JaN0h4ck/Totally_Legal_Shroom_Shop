extends Node2D

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
func spawn_corpse(corpse_name: GLOBALS.npc_names):
	var node: PickableCorpse = PickableCorpse.new()
	add_child(node)
	match corpse_name:
		GLOBALS.npc_names.alien:
			node.corpse_res = corpse_resource_alien
		GLOBALS.npc_names.angry:
			node.corpse_res = corpse_resource_angry
		GLOBALS.npc_names.beff:
			node.corpse_res = corpse_resource_beff
		GLOBALS.npc_names.celeb:
			node.corpse_res = corpse_resource_celeb
		GLOBALS.npc_names.conspiracy:
			node.corpse_res = corpse_resource_conspiracy
		GLOBALS.npc_names.cook:
			node.corpse_res = corpse_resource_cook
		GLOBALS.npc_names.cowboy:
			node.corpse_res = corpse_resource_cowboy
		GLOBALS.npc_names.enthusiast:
			node.corpse_res = corpse_resource_enthusiast
		GLOBALS.npc_names.nerd:
			node.corpse_res = corpse_resource_nerd
		GLOBALS.npc_names.opa:
			node.corpse_res = corpse_resource_grandpa
		_:
			node.queue_free()
			printerr("NPC Name not found: ", corpse_name)
	
	node.prepare_item()
