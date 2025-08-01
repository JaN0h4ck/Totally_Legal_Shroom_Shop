extends Node2D

@onready var corpse_alien := preload("res://scenes/Object/corpses/alien_corpse.tscn")
@onready var corpse_resource_alien := preload("res://pick_up_system/corpses/alien_corpse.tres")

var corpse

func _ready():
	EventBus.npc_dropped.connect(spawn_npc_corpse)

# alien, angry, beff, celeb, conspiracy, cook, cowboy, enthusiast, nerd, opa
func spawn_npc_corpse(corpse_name : base_npc.npc_name_enum):
	pass

func spawn_corpe(corpse_name : base_npc.npc_name_enum):
	var corpse : pickable_object = pickable_object.new()
	match corpse_name:
		_:
			corpse.selected_object = corpse_resource_alien
		base_npc.npc_name_enum.alien:
			corpse.selected_object = corpse_resource_alien
	
	corpse.create_corpse()
