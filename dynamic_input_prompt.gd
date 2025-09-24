extends InputPrompt

@onready var disabled_label: Label = $HBoxContainer/VBoxContainer/disabled_label

@export var disabled_text: String
@export var disabled_modulate: Color = "FFFFFF"
var disabled: bool = false

func _ready() -> void:
	super()
	disabled_label.text =  disabled_text
	disabled_label.visible = false

func deactivate():
	if disabled: return
	disabled = true
	disabled_label.visible = true
	modulate = disabled_modulate

func activate():
	if not disabled: return
	disabled = false
	disabled_label.visible = false
	modulate = "FFFFFF"
