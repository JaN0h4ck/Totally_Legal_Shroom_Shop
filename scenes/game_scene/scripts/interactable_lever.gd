extends Interactable

const _2D_OUTLINE = preload("uid://5gys6hamkwkm")
@onready var lever: Sprite2D = $".."

func _ready():
	super()
	player_entered.connect(show_outline)
	player_left.connect(hide_outline)

func show_outline(_arg1, _arg2):
	lever.material = _2D_OUTLINE

func hide_outline(_arg):
	lever.material = null

func _on_player_interacted():
	EventBus.interact_lever.emit()
