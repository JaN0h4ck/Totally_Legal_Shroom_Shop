extends VBoxContainer

@onready var texture: TextureRect = $Display/Texture
@onready var amount_label: Label = $Display/Label
@onready var button: Button = $Button
## Position im Inventar, muss für jeden ui_item einzigartig sein, aufsteigend von 0
@export_range(0, 100) var inventory_position : int

var button_text_empty = "Add Shroom"
var button_text_filled = "Take Shroom"

## Globale Config Ressource
var config : GlobalConfig = load("res://resources/global_config.tres")

var mushroom_global_positon : Vector2 = Vector2(0, 0)
var mushroom_global_rotation : float = 0.0

func _ready():
	EventBus.inventory_updated.connect(check_inventory)
	set_mushroom_global_position()
	check_inventory()

# Überprüfen ob Slot leer ist
func check_inventory():
	var item : Array = Inventory.get_mushroom_type_at_position(inventory_position)
	if item[0] == null:
		empty_slot()
	else:
		filled_slot(item)

# Wenn Slot leer ist
func empty_slot():
	texture.texture = null
	amount_label.text = ""
	button.text = button_text_empty

# Wenn Slot ein Item enthält
func filled_slot(item : Array):
	var mushroom : PickableMushroom = item[0]
	var amount : int = item[1]
	texture.texture = mushroom.shroom_res.end_stage_texture
	amount_label.text = str(amount)
	button.text = button_text_filled

# Wenn Knopf gedrückt wird
func _on_button_pressed() -> void:
	if button.text == button_text_empty:
		add_item()
	else:
		remove_item()

func remove_item():
	var player : Player = get_tree().get_first_node_in_group("player")
	# Schauen ob Spieler bereits ein Objekt trägt
	if player.carries_object and config.player_carry_only_one_item:
		print("Player is already carring an object")
		return
	# Objekt Spieler übergeben
	var item : Array = Inventory.get_mushroom_type_at_position(inventory_position)
	item[0].add_to_player()
	# Objekt entfernen
	var _succes = Inventory.remove_mushroom_from_inventory_by_position(inventory_position)

## Pilz zum Inventar an aktueller stelle hinzufügen
func add_item():
	# Schauen ob Spieler einen Pilz dabei hat
	var player : Player = get_tree().get_first_node_in_group("player")
	var mushroom
	if player.carries_object:
		for child in player.object_place.get_children():
			if child.is_in_group("pickable_mushroom"):
				mushroom = child
	if mushroom == null:
		print("Player has no Mushroom")
		return
	# Pilz zum Inventar hinzufügen und überprüfen ob erfolgreich
	var succes = Inventory.add_mushroom_to_inventory_fix_position(mushroom, inventory_position)
	if not succes:
		print("Adding Mushroom Failed")
		return
	# Pilz auf der Theke Platzieren
	mushroom.crush_object()
	mushroom.set_collision_size_to_zero()
	mushroom.position = Vector2(0, 0)
	mushroom.rotation = 0.0
	mushroom.global_position = mushroom_global_positon
	mushroom.global_rotation = mushroom_global_rotation

func set_mushroom_global_position():
	var position_nodes = get_tree().get_nodes_in_group("mushroom_inventory_display_position")
	for node in position_nodes:
		var node_name = node.name
		var name_parts = node_name.split("_")
		if name_parts.size() > 1:
			var number = int(name_parts[1])
			if number == inventory_position:
				mushroom_global_positon = node.global_position
				mushroom_global_rotation = node.global_rotation
	
