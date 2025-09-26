extends Sprite2D
class_name mushroom_spawn_system

@onready var mushroom_resource_alien := preload("res://PickUpSystem/mushroom/alien_mushroom.tres")
@onready var murhroom_resource_bleeding := preload("res://PickUpSystem/mushroom/bleeding_mushroom.tres")
@onready var murhroom_resource_button := preload("res://PickUpSystem/mushroom/button_mushroom.tres")
@onready var murhroom_resource_chanterella := preload("res://PickUpSystem/mushroom/chanterella_mushroom.tres")
@onready var murhroom_resource_ribcage := preload("res://PickUpSystem/mushroom/ribcage_mushroom.tres")
@onready var murhroom_resource_toxic := preload("res://PickUpSystem/mushroom/toxic_mushroom.tres")
@onready var mushroom_resource_flyagaric := preload("res://PickUpSystem/mushroom/flyagaric_mushroom.tres")
@onready var mushroom_resource_shiitake := preload("res://PickUpSystem/mushroom/shiitake_mushroom.tres")
@onready var mushroom_resource_oyster := preload("res://PickUpSystem/mushroom/oyster_mushroom.tres")
@onready var mushroom_resource_chestnut := preload("res://PickUpSystem/mushroom/chestnut_mushroom.tres")
@onready var mushroom_resource_enoki := preload("res://PickUpSystem/mushroom/enoki_mushroom.tres")

## Globale Config Ressource
var config: GlobalConfig = load("res://resources/global_config.tres")

var print_info : bool = false
var common_mushroom: Array
var rare_mushroom: Array
var ultra_rare_mushroom: Array
var position_to_bool := {}
var current_position: Vector2 = Vector2(0, 0)

func _ready():
	EventBus.pickup_object.connect(clear_field)
	EventBus.load_mushroom.connect(load_mushroom)
	EventBus.inventory_remove_mushroom.connect(take_mushroom_from_inventory)
	EventBus.display_mushroom.connect(display_inventory_mushroom)
	print_info = config.print_info_messages
	add_mushroom_to_array(mushroom_resource_alien)
	add_mushroom_to_array(murhroom_resource_bleeding)
	add_mushroom_to_array(murhroom_resource_button)
	add_mushroom_to_array(murhroom_resource_chanterella)
	add_mushroom_to_array(murhroom_resource_ribcage)
	add_mushroom_to_array(murhroom_resource_toxic)
	add_mushroom_to_array(mushroom_resource_flyagaric)
	add_mushroom_to_array(mushroom_resource_shiitake)
	add_mushroom_to_array(mushroom_resource_oyster)
	add_mushroom_to_array(mushroom_resource_chestnut)
	add_mushroom_to_array(mushroom_resource_enoki)

## Legt werte fest und erzeugt den Pilz
func spawn_mushroom_seed(location: Vector2) -> bool:
	# Schauen ob dort bereits ein Pilz ist
	if get_position_value(location):
		return false
	current_position = location
	set_position_value(location, true)
	#print("interacted at ", location)
	var check = check_if_player_has_fertilizer()
	if not check[0]:
		if config.grow_without_fertilizer:
			create_mushroom(GLOBALS.rarity.common, location)
			return true
		else:
			print("no fertilizer")
		return false
	else:
		var player: Player = get_tree().get_first_node_in_group("player")
		var fertilizer: PickableFertilizer = player.object_place.get_child(check[1])
		var fertilizer_rarity: GLOBALS.rarity = fertilizer.fert_res.rarity
		create_mushroom(fertilizer_rarity, location)
		#print("Fertilizer Rarity: ", fertilizer_rarity)
		use_fertilizer(fertilizer)
		return true

## Schaut ob der Spieler mommentan Dünger in der Hand hat
func check_if_player_has_fertilizer():
	var player: Player = get_tree().get_first_node_in_group("player")
	for child in player.object_place.get_children():
		if child.is_in_group("pickable_fertilizer"):
			return [true, child.get_index()]
	return [false, 0]

## Wählt einen zufälligen Pilz bassierend auf der seltenheit des Düngers aus
func create_mushroom(soil_rarity: GLOBALS.rarity, location: Vector2):
	var node: PickableMushroom = PickableMushroom.new()
	add_child(node)
	match soil_rarity:
		GLOBALS.rarity.common:
			node.shroom_res = common_mushroom.pick_random()
		GLOBALS.rarity.rare:
			node.shroom_res = rare_mushroom.pick_random()
		GLOBALS.rarity.ultra_rare:
			node.shroom_res = ultra_rare_mushroom.pick_random()
	node.global_position = location
	node.add_to_group("Shroom")
	node.prepare_item()

## Gespeicherten Pilz Spawnen
func load_mushroom(shroom_res : ShroomRes, saved_position : Vector2, saved_rotation : float, grow_stage : int):
	var node: PickableMushroom = PickableMushroom.new()
	add_child(node)
	node.shroom_res = shroom_res
	node.global_position = saved_position
	node.global_rotation = saved_rotation
	node.add_to_group("Shroom")
	node.load_item(grow_stage)

## Pilz aus Inventar zu Spieler hinzufügen
func take_mushroom_from_inventory(shroom_res : ShroomRes):
	var mushroom : PickableMushroom = PickableMushroom.new()
	mushroom.shroom_res = shroom_res
	var player : Player = get_tree().get_first_node_in_group("player")
	player.object_place.add_child(mushroom)
	player.carries_object = true
	mushroom.position = Vector2(0,0)
	mushroom.global_rotation = 0.0
	mushroom.add_to_group("Shroom")
	mushroom.load_item(3)

func display_inventory_mushroom(shroom_res : ShroomRes, slot : int):
	if print_info:
		print("Mushroom Spawn System: Try to display ", shroom_res, " from Slot ", slot)
	var mushroom : PickableMushroom = PickableMushroom.new()
	mushroom.shroom_res = shroom_res
	mushroom.display_item()
	mushroom.is_pickable = false
	mushroom.is_picked = false
	for parent in get_tree().get_nodes_in_group("mushroom_inventory_display_position"):
		if str(slot) in parent.name:
			if print_info:
				print("Mushroom Spawn System: Display from Slot parent ", parent, " found")
			parent.add_child(mushroom)
			return
	if print_info:
		print("Mushroom _Spawn System: No Display from Slot Parent Found")

## Dünger zu Feld bewegen und dann löschen
func use_fertilizer(fertilizer: PickableFertilizer):
	fertilizer.crush_object()
	var tween = get_tree().create_tween()
	tween.tween_property(fertilizer, "global_position", current_position, fertilizer.fert_res.pickup_time).from_current()
	# Warten bevor Leiche verschwindet
	await get_tree().create_timer(fertilizer.fert_res.pickup_time + 0.1).timeout
	if is_instance_valid(fertilizer):
		fertilizer.queue_free()

## Fügt den Pilz zum passenden Array hinzu
func add_mushroom_to_array(mushroom):
	match mushroom.rarity:
		GLOBALS.rarity.common:
			common_mushroom.append(mushroom)
		GLOBALS.rarity.rare:
			rare_mushroom.append(mushroom)
		GLOBALS.rarity.ultra_rare:
			ultra_rare_mushroom.append(mushroom)

## Speichern dass ein Pilz bereits an diesem Ort ist
func set_position_value(pos: Vector2, value: bool) -> void:
	position_to_bool[pos] = value

## Schauen ob an diesem Ort bereits ein Pilz ist
func get_position_value(pos: Vector2) -> bool:
	return position_to_bool.get(pos, false)

## Feld wieder frei machen wenn Pilz aufgehoben wird
func clear_field(field_position: Vector2, is_random_dropped: bool):
	if is_random_dropped:
		return
	if get_position_value(field_position):
		set_position_value(field_position, false)

## Schaut ob der Spieler mommentan einen Pilz in der Hand hat
func check_if_player_has_mushroom():
	var player: Player = get_tree().get_first_node_in_group("player")
	for child in player.object_place.get_children():
		if child.is_in_group("pickable_mushroom"):
			return true
	return false
