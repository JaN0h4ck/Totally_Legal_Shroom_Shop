extends Node2D
class_name journal_kill_list

@onready var icon: Sprite2D = $HBoxContainer/Icon
@onready var text: Label = $HBoxContainer/Text

func _ready() -> void:
	pass

func update_text(number : int):
	print(text)
	text.text = str(number)

func update_icon(killed_npc : GLOBALS.npc_names):
	match killed_npc:
		GLOBALS.npc_names.alien:
			icon.texture = load("res://assets/character/alien/alien_portrait.png")
		GLOBALS.npc_names.angry:
			icon.texture = load("res://assets/character/angry/angry_portrait.png")
		GLOBALS.npc_names.beff:
			icon.texture = load("res://assets/character/beff/beff_portrait.png")
		GLOBALS.npc_names.celeb:
			icon.texture = load("res://assets/character/celebrity/celeb_portrait.png")
		GLOBALS.npc_names.conspiracy:
			icon.texture = load("res://assets/character/conspiracy/conspiracy_portrait.png")
		GLOBALS.npc_names.cook:
			icon.texture = load("res://assets/character/cook/cook_portrait.png")
		GLOBALS.npc_names.cowboy:
			icon.texture = load("res://assets/character/cowboy/cowboy_portrait.png")
		GLOBALS.npc_names.enthusiast:
			icon.texture = load("res://assets/character/enthusiast/enthusiast_portrait.png")
		GLOBALS.npc_names.nerd:
			icon.texture = load("res://assets/character/nerd/nerd_portrait.png")
		GLOBALS.npc_names.opa:
			icon.texture = load("res://assets/character/grandpa/grandpa_portrait.png")
