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

func _ready():
	EventBus.inventory_updated.connect(check_inventory)
	check_inventory()

# Überprüfen ob Slot leer ist
func check_inventory():
	var item : Array = Inventory.get_mushroom_type_at_position(inventory_position)
	if item[0] == "empty":
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
	var mushroom : ShroomRes = item[0]
	var amount : int = item[1]
	texture.texture = mushroom.end_stage_texture
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

func add_item():
	pass
