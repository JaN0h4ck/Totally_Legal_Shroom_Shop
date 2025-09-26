extends PanelContainer

## Position im Inventar, muss für jeden ui_item einzigartig sein, aufsteigend von 0
@export_range(0, 200) var inventory_position : int
## ob die Node Fokus grabben soll, darf nur bei einer Control Node aktiv sein!
@export var grab_focus_on_ready: bool = false

## Pilz Bild
@onready var texture: TextureRect = $MarginContainer/HBoxContainer/Texture
## Pilz Name
@onready var mushrrom_name: Label = $MarginContainer/HBoxContainer/VBoxContainerInfo/Name
## Pilze anzahl
@onready var number_text: Label = $MarginContainer/HBoxContainer/VBoxContainerInfo/HBoxContainerNumber/NumberText
## Pilz Wert
@onready var number_coin_text: Label = $MarginContainer/HBoxContainer/VBoxContainerInfo/HBoxContainerWorth/NumberCoinText
## Knopf zum nehmen aus aktuellem Slot
@onready var button_take: Button = $MarginContainer/HBoxContainer/VBoxContainerButtons/ButtonTake

## Globale Config Ressource
var config : GlobalConfig = load("res://resources/global_config.tres")
var print_info : bool = false

func _ready():
	EventBus.inventory_updated.connect(update_displayed_info)
	print_info = config.print_info_messages
	update_displayed_info()

## Aktualliesiere Anzeige
func update_displayed_info():
	if print_info:
		print("Inventory Slot: Updating Slot ", inventory_position)
	if check_if_slot_empty():
		if print_info:
			print("Inventory Slot: Slot ", inventory_position, " is Empty")
		texture.texture = load("res://assets/shrooms/empty_shroom.png")
		mushrrom_name.text = ""
		number_text.text = str(0)
		number_coin_text.text = str(0)
		button_take.visible = false
	else:
		set_slot_info()
		if print_info:
			print("Inventory Slot: Slot ", inventory_position, " is not Empty")
	
## Überprüft ob Inventar Slot Leer ist
func check_if_slot_empty():
	# Schaut ob Inventar Slot schon existiert
	if Inventory.inventory_array.size() <= inventory_position:
		return true
	# Schaut ob Inventar Slot aktuell Leer ist
	if Inventory.inventory_array[inventory_position][1] == 0:
		return true
	return false

## Aktuelle Anzeige aktualliesieren
func set_slot_info():
	var slot_info : Array = Inventory.inventory_array[inventory_position]
	var mushroom_res : ShroomRes = slot_info[0]
	var mushroom_number : int = slot_info[1]
	texture.texture = mushroom_res.end_stage_texture
	mushrrom_name.text = str(mushroom_res.name)
	number_text.text = str(mushroom_number)
	match mushroom_res.rarity:
		GLOBALS.rarity.common:
			number_coin_text.text = str(config.money_common_mushroom)
		GLOBALS.rarity.rare:
			number_coin_text.text = str(config.money_rare_mushroom)
		GLOBALS.rarity.ultra_rare:
			number_coin_text.text = str(config.money_ultra_rare_mushroom)
	button_take.visible = true


func _on_button_add_pressed() -> void:
	if print_info:
		print("Inventory Slot: Slot ", inventory_position, " Add Button Pressed")
	var player : Player = get_tree().get_first_node_in_group("player")
	if player.carries_object:
		EventBus.inventory_add_object_specific_slot.emit(player.object_place.get_child(0), inventory_position)
		return
	if print_info:
		print("Inventory Slot: Slot ", inventory_position, " tried to add Item but Player has no Item")

func _on_button_take_pressed() -> void:
	if print_info:
		print("Inventory Slot: Slot ", inventory_position, " Take Button Pressed")
