extends Node
class_name mushroom_spawn_system

@onready var pickable_object_scene := preload("res://pick_up_system/pickable_object.tscn")
@onready var mushroom_resource_alien := preload("res://pick_up_system/mushroom/alien_mushroom.tres")
@onready var murhroom_resource_bleeding := preload("res://pick_up_system/mushroom/bleeding_mushroom.tres")
@onready var murhroom_resource_button := preload("res://pick_up_system/mushroom/button_mushroom.tres")
@onready var murhroom_resource_chanterella := preload("res://pick_up_system/mushroom/chanterella_mushroom.tres")
@onready var murhroom_resource_ribcage := preload("res://pick_up_system/mushroom/ribcage_mushroom.tres")
@onready var murhroom_resource_toxic := preload("res://pick_up_system/mushroom/toxic_mushroom.tres")
@onready var mushroom_resource_flyagaric := preload("res://pick_up_system/mushroom/flyagaric_mushroom.tres")

## Globale Cinfig Ressource
var config : GlobalConfig = load("res://resources/global_config.tres")

var common_mushroom : Array
var rare_mushroom : Array
var ultra_rare_mushroom : Array
var position_to_bool := {}
var current_position : Vector2 = Vector2(0,0)

func _ready():
	EventBus.pickup_object.connect(clear_field)
	add_mushroom_to_array(mushroom_resource_alien)
	add_mushroom_to_array(murhroom_resource_bleeding)
	add_mushroom_to_array(murhroom_resource_button)
	add_mushroom_to_array(murhroom_resource_chanterella)
	add_mushroom_to_array(murhroom_resource_ribcage)
	add_mushroom_to_array(murhroom_resource_toxic)
	add_mushroom_to_array(mushroom_resource_flyagaric)

## Legt werte fest und erzeugt den Pilz
func spawn_mushroom_seed(location : Vector2):
	# Schauen ob dort bereits ein Pilz ist
	if get_position_value(location):
		return
	current_position = location
	set_position_value(location, true)
	#print("interacted at ", location)
	var check = check_if_player_has_fertilizer()
	if not check[0]:
		if config.grow_without_fertilizer:
			create_mushroom(pickable_object_resource.rarity_enum.common, location)
		else:
			print("no fertilizer")
		return
	else:
		var player : Player = get_tree().get_first_node_in_group("player")
		var fertilizer : pickable_object = player.object_place.get_child(check[1])
		var fertilizer_rarity : pickable_object_resource.rarity_enum = fertilizer.selected_object.rarity
		create_mushroom(fertilizer_rarity, location)
		#print("Fertilizer Rarity: ", fertilizer_rarity)
		use_fertilizer(fertilizer)

## Schaut ob der Spieler mommentan Dünger in der Hand hat
func check_if_player_has_fertilizer():
	var player : Player = get_tree().get_first_node_in_group("player")
	for child in player.object_place.get_children():
		if child.is_in_group("pickable_fertilizer"):
			return [true, child.get_index()]
	return [false, 0]

## Wählt einen zufälligen Pilz bassierend auf der seltenheit des Düngers aus
func create_mushroom(soil_rarity : pickable_object_resource.rarity_enum, location : Vector2):
	var scene : pickable_object = pickable_object_scene.instantiate()
	add_child(scene)
	match soil_rarity:
		pickable_object_resource.rarity_enum.common:
			scene.selected_object = common_mushroom.pick_random()
		pickable_object_resource.rarity_enum.rare:
			scene.selected_object = rare_mushroom.pick_random()
		pickable_object_resource.rarity_enum.ultra_rare:
			scene.selected_object = ultra_rare_mushroom.pick_random()
	scene.global_position = location
	scene.create_mushroom()

## Dünger zu Feld bewegen und dann löschen
func use_fertilizer(fertilizer : pickable_object):
	fertilizer.crush_object()
	var tween = get_tree().create_tween()
	tween.tween_property(fertilizer, "global_position", current_position, fertilizer.selected_object.pickup_time).from_current()
	# Warten bevor Leiche verschwindet
	await get_tree().create_timer(fertilizer.selected_object.pickup_time + 0.1).timeout
	if is_instance_valid(fertilizer):
		fertilizer.queue_free()

## Fügt den Pilz zum passenden Array hinzu
func add_mushroom_to_array(mushroom):
	match mushroom.rarity:
		pickable_object_resource.rarity_enum.common:
			common_mushroom.append(mushroom)
		pickable_object_resource.rarity_enum.rare:
			rare_mushroom.append(mushroom)
		pickable_object_resource.rarity_enum.ultra_rare:
			ultra_rare_mushroom.append(mushroom)

## Speichern dass ein Pilz bereits an diesem Ort ist
func set_position_value(pos: Vector2, value: bool) -> void:
	position_to_bool[pos] = value

## Schauen ob an diesem Ort bereits ein Pilz ist
func get_position_value(pos: Vector2) -> bool:
	return position_to_bool.get(pos, false)

## Feld wieder frei machen wenn Pilz aufgehoben wird
func clear_field(field_position : Vector2, is_random_dropped : bool):
	if is_random_dropped:
		return
	if get_position_value(field_position):
		set_position_value(field_position, false)

## Schaut ob der Spieler mommentan einen Pilz in der Hand hat
func check_if_player_has_mushroom():
	var player : Player = get_tree().get_first_node_in_group("player")
	for child in player.object_place.get_children():
		if child.is_in_group("pickable_mushroom"):
			return true
	return false
