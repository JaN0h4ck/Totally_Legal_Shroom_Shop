extends Node2D

@onready var npc_icon: Sprite2D = $HBoxContainer/NPCIcon
@onready var text: Label = $HBoxContainer/Text

func _ready() -> void:
	pass

func update_text(number : int):
	text.text = str(number)

func update_icon_to_killed(killed_npc : GLOBALS.npc_names):
	match killed_npc:
		GLOBALS.npc_names.alien:
			npc_icon.texture = load("res://assets/character/alien/alien_portrait.png")
		GLOBALS.npc_names.angry:
			npc_icon.texture = load("res://assets/character/angry/angry_portrait.png")
		GLOBALS.npc_names.beff:
			npc_icon.texture = load("res://assets/character/beff/beff_portrait.png")
		GLOBALS.npc_names.celeb:
			npc_icon.texture = load("res://assets/character/celebrity/celeb_portrait.png")
		GLOBALS.npc_names.conspiracy:
			npc_icon.texture = load("res://assets/character/conspiracy/conspiracy_portrait.png")
		GLOBALS.npc_names.cook:
			npc_icon.texture = load("res://assets/character/cook/cook_portrait.png")
		GLOBALS.npc_names.cowboy:
			npc_icon.texture = load("res://assets/character/cowboy/cowboy_portrait.png")
		GLOBALS.npc_names.enthusiast:
			npc_icon.texture = load("res://assets/character/enthusiast/enthusiast_portrait.png")
		GLOBALS.npc_names.nerd:
			npc_icon.texture = load("res://assets/character/nerd/nerd_portrait.png")
		GLOBALS.npc_names.opa:
			npc_icon.texture = load("res://assets/character/grandpa/grandpa_portrait.png")
