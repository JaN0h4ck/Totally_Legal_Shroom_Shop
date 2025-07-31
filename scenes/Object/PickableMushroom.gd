extends PickableObject

@export var item_res: InvItem
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	super()

func _init_sprite():
	if item_res == null:
		push_error("mushroom resource not set!")
		return
	sprite.texture = item_res.texture
