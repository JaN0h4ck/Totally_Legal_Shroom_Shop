@tool
extends OverlaidMenu

@export var inventory: Inv
@onready var buttons: Array[Button] = [$CenterContainer/HBoxContainer/Button,$CenterContainer/HBoxContainer/Button2,$CenterContainer/HBoxContainer/Button3,$CenterContainer/HBoxContainer/Button4,$CenterContainer/HBoxContainer/Button5]

const NR_OF_ITEMS: int = 5

func _ready() -> void:
	render_inv()

func render_inv():
	if inventory == null: return
	if (inventory.items.size() < NR_OF_ITEMS) or (buttons.size() > NR_OF_ITEMS): return
	for i in range(NR_OF_ITEMS):
		buttons[i].icon =  null if inventory.items[i] == null else inventory.items[i].texture

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		close()
