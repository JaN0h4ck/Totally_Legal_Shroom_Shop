extends PanelContainer

@onready var inventory_slot_1: hotbar_ui_item = $MarginContainer/HBoxContainer/InventorySlot1
@onready var inventory_slot_2: hotbar_ui_item = $MarginContainer/HBoxContainer/InventorySlot2
@onready var inventory_slot_3: hotbar_ui_item = $MarginContainer/HBoxContainer/InventorySlot3
@onready var inventory_slot_4: hotbar_ui_item = $MarginContainer/HBoxContainer/InventorySlot4

## Globale Config Ressource
var config: GlobalConfig = load("res://resources/global_config.tres")
var active_slot : int = 1
var max_slot : int = 4

func _ready() -> void:
	set_active_slot()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("hotbar_move_right"):
		print("down")
		change_active_slot(true)
	if Input.is_action_just_pressed("hotbar_move_left"):
		print("up")
		change_active_slot(false)

## Aktiven Slot ändern, true für nach Rechts, false für nach links
func change_active_slot(right : bool):
	if right:
		active_slot += 1
	else:
		active_slot -= 1
	if active_slot > max_slot:
		active_slot = 1
	if active_slot < 1:
		active_slot = max_slot
	set_active_slot()
	EventBus.inventory_updated.emit()

func set_active_slot():
	match active_slot:
		1:
			inventory_slot_1.active_slot = true
			inventory_slot_2.active_slot = false
			inventory_slot_3.active_slot = false
			inventory_slot_4.active_slot = false
		2:
			inventory_slot_1.active_slot = false
			inventory_slot_2.active_slot = true
			inventory_slot_3.active_slot = false
			inventory_slot_4.active_slot = false
		3:
			inventory_slot_1.active_slot = false
			inventory_slot_2.active_slot = false
			inventory_slot_3.active_slot = true
			inventory_slot_4.active_slot = false
		4:
			inventory_slot_1.active_slot = false
			inventory_slot_2.active_slot = false
			inventory_slot_3.active_slot = false
			inventory_slot_4.active_slot = true
