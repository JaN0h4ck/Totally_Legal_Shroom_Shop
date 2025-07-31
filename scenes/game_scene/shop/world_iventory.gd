@tool
extends Node2D

const NR_OF_ITEMS: int = 5

@export var inventory_res: Inv
@onready var sprites: Array[Sprite2D] = [
	$Sprite2D,
	$Sprite2D2,
	$Sprite2D3,
	$Sprite2D4,
	$Sprite2D5
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	render_items()

func render_items():
	if inventory_res == null:
		push_error("No Iventory set lol")
		return
	if (inventory_res.items.size() < NR_OF_ITEMS) or (sprites.size() < NR_OF_ITEMS):
		push_error("Wrong amount inventory items or sprites")
		return
	for i in range(NR_OF_ITEMS):
		sprites[i].texture = null if inventory_res.items[i] == null else inventory_res.items[i].texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
