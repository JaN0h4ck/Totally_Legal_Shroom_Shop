class_name InputPrompt
extends Panel

@export var text: String
@export var action_name: String
@onready var input_icon_mapper: InputIconMapper = $InputIconMapper
@onready var icon_display: TextureRect = $HBoxContainer/IconDisplay
@onready var label: Label = $HBoxContainer/VBoxContainer/Label
var interactable_name: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon_display.texture = get_icon(action_name, InputDeviceMonitor.is_gamepad)
	label.text = text

func get_icon(_name: String, _is_gamepad: bool):
	var input_events = InputMap.action_get_events(_name)
	if(input_events == null or input_events.size() == 0): return null
	
	var evt: InputEvent = input_events[1 if _is_gamepad else 0]
	if evt == null: evt = input_events[0]
	
	var result = input_icon_mapper.get_icon(evt)
	return result
