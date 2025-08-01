@tool
class_name InvUIItem
extends VBoxContainer

@onready var texture: TextureRect = $Display/Texture
@onready var label: Label = $Display/Label
@onready var button: Button = $Button
var _mushroom: InvItem
var mushroom: InvItem: 
	get: return _mushroom
	set(value):
		_render_item(value)
		_mushroom = value

func _render_item(shroom:InvItem):
	if shroom == null:
		texture.texture = null
		label.text = ""
		button.text = "Add Shroom"
		return
	texture.texture = shroom.texture
	label.text = str(shroom.amount)
	button.text = "Take Shroom"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
