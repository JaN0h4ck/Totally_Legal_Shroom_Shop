extends HBoxContainer

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label

func _ready() -> void:
	pass

func update_text(number : int):
	label.text = str(number)

func update_icon_to_killed(killed_npc : GLOBALS.npc_names):
	match killed_npc:
		GLOBALS.npc_names.alien:
			texture_rect.texture = load("res://assets/character/alien/alien_portrait.png")
		GLOBALS.npc_names.angry:
			texture_rect.texture = load("res://assets/character/angry/angry_portrait.png")
		GLOBALS.npc_names.beff:
			texture_rect.texture = load("res://assets/character/beff/beff_portrait.png")
		GLOBALS.npc_names.celeb:
			texture_rect.texture = load("res://assets/character/celebrity/celeb_portrait.png")
		GLOBALS.npc_names.conspiracy:
			texture_rect.texture = load("res://assets/character/conspiracy/conspiracy_portrait.png")
		GLOBALS.npc_names.cook:
			texture_rect.texture = load("res://assets/character/cook/cook_portrait.png")
		GLOBALS.npc_names.cowboy:
			texture_rect.texture = load("res://assets/character/cowboy/cowboy_portrait.png")
		GLOBALS.npc_names.enthusiast:
			texture_rect.texture = load("res://assets/character/enthusiast/enthusiast_portrait.png")
		GLOBALS.npc_names.nerd:
			texture_rect.texture = load("res://assets/character/nerd/nerd_portrait.png")
		GLOBALS.npc_names.opa:
			texture_rect.texture = load("res://assets/character/grandpa/grandpa_portrait.png")
