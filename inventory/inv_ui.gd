@tool
extends OverlaidMenu

@export var inventory: Inv
@onready var buttons: Array[InvUIItem] = [
	$CenterContainer/HBoxContainer/UIItem,
	$CenterContainer/HBoxContainer/UIItem2,
	$CenterContainer/HBoxContainer/UIItem3,
	$CenterContainer/HBoxContainer/UIItem4,
	$CenterContainer/HBoxContainer/UIItem5
]

const NR_OF_ITEMS: int = 5

func _ready() -> void:
	render_inv()

func render_inv():
	if inventory == null: return
	if (inventory.items.size() < NR_OF_ITEMS) or (buttons.size() > NR_OF_ITEMS): return
	for i in range(NR_OF_ITEMS):
		buttons[i].mushroom = inventory.items[i]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		close()
