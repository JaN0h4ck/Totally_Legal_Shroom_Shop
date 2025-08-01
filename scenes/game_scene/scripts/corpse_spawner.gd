extends Node2D

@onready var corpse_alien := preload("res://scenes/Object/corpses/alien_corpse.tscn")
@onready var corpse_angry := preload("res://scenes/Object/corpses/angry_corpse.tscn")
@onready var corpse_beff := preload("res://scenes/Object/corpses/beff_jezoz_corpse.tscn")
@onready var corpse_celeb := preload("res://scenes/Object/corpses/celeb_corpse.tscn")
@onready var corpse_conspirary := preload("res://scenes/Object/corpses/conspiracy_corpse.tscn")
@onready var corpse_cook := preload("res://scenes/Object/corpses/cook_corpse.tscn")
@onready var corpse_cowboy := preload("res://scenes/Object/corpses/cowboy_corpse.tscn")
@onready var corpse_enthusiast := preload("res://scenes/Object/corpses/enthusiast_corpse.tscn")
@onready var corpse_nerd := preload("res://scenes/Object/corpses/nerd_corpse.tscn")
@onready var corpse_opa := preload("res://scenes/Object/corpses/opa_corpse.tscn")

var corpse

func _ready():
	EventBus.npc_dropped.connect(spawn_npc_corpse)

# alien, angry, beff, celeb, conspiracy, cook, cowboy, enthusiast, nerd, opa
func spawn_npc_corpse(corpse_name : base_npc.npc_name_enum):
	match corpse_name:
		base_npc.npc_name_enum.alien:
			corpse = corpse_alien.instantiate()
		base_npc.npc_name_enum.angry:
			corpse = corpse_angry.instantiate()
		base_npc.npc_name_enum.beff:
			corpse = corpse_beff.instantiate()
		base_npc.npc_name_enum.celeb:
			corpse = corpse_celeb.instantiate()
		base_npc.npc_name_enum.conspiracy:
			corpse = corpse_conspirary.instantiate()
		base_npc.npc_name_enum.cook:
			corpse = corpse_cook.instantiate()
		base_npc.npc_name_enum.cowboy:
			corpse = corpse_cowboy.instantiate()
		base_npc.npc_name_enum.enthusiast:
			corpse = corpse_enthusiast.instantiate()
		base_npc.npc_name_enum.nerd:
			corpse = corpse_nerd.instantiate()
		base_npc.npc_name_enum.opa:
			corpse = corpse_opa.instantiate()
	
	add_child(corpse)
