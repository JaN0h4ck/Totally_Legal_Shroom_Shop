extends PickableRes
class_name ShroomRes

## Texture wenn der Pilz zur hälfte gewachsen ist
@export var middle_stage_texture : Texture2D
## Texture wenn der Pilz voll ausgewachsen ist
@export var end_stage_texture : Texture2D

## Wie lange der Pilz braucht um zur hälfte gewachsen zu sein
var grow_time_middle : float:
	get:
		match rarity:
			GLOBALS.rarity.common:
				return config.common_mushroom_grow_time_stage_1
			GLOBALS.rarity.rare:
				return config.rare_mushroom_grow_time_stage_1
			GLOBALS.rarity.ultra_rare:
				return config.ultra_rare_mushroom_grow_time_stage_1
			_:
				print("Mushroom resource not matching rarity selected")
				return 0

## Wie lange der Pilz braucht um vom mittleren ins end stdium zu wachsen
var grow_time_end : float:
	get:
		match rarity:
			GLOBALS.rarity.common:
				return config.common_mushroom_grow_time_stage_2
			GLOBALS.rarity.rare:
				return config.rare_mushroom_grow_time_stage_2
			GLOBALS.rarity.ultra_rare:
				return config.ultra_rare_mushroom_grow_time_stage_2
			_:
				print("Mushroom resource not matching rarity selected")
				return 0

func _init() -> void:
	if base_texture == null:
		print("Mushroom resource no base texture set, freshlyplanted used")
		base_texture = preload("res://assets/shrooms/freshlyplanted.png")
