extends PanelContainer
class_name hotbar_ui_item

## Position im Inventar, muss für jeden ui_item einzigartig sein, aufsteigend von 0
@export_range(1, 200) var inventory_position : int
## Bild
@onready var texture: TextureRect = $MarginContainer/Texture
## Rahmen Container
@onready var inventory_slot: PanelContainer = $"."

## Globale Config Ressource
var config : GlobalConfig = load("res://resources/global_config.tres")
var print_info : bool = false
@export var active_slot : bool = false

func _ready():
	EventBus.inventory_updated.connect(update_displayed_info)
	EventBus.drop_object.connect(drop_object)
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
	else:
		set_slot_info()
		if print_info:
			print("Inventory Slot: Slot ", inventory_position, " is not Empty")
	if active_slot:
		set_border_color(Color(0,1,0))
	else:
		set_border_color(Color(0,0,0))

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
	var mushroom_res = slot_info[0]
	texture.texture = mushroom_res.end_stage_texture

func drop_object():
	if not active_slot:
		return
	print("Drop this object")

func set_border_color(new_color : Color):
	var shelf_border = inventory_slot.get_theme_stylebox("panel").duplicate()
	shelf_border.border_color = new_color
	inventory_slot.add_theme_stylebox_override("panel",shelf_border)
