extends Node

signal input_device_changed(is_gamepad: bool)
var is_gamepad: bool = false
var ignore_mouse: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if((event is InputEventKey) or (event is InputEventMouse and not ignore_mouse)):
		if not is_gamepad: return
		is_gamepad = false
		input_device_changed.emit(false)
		return
	if is_gamepad: return;
	if(event is InputEventJoypadButton or event is InputEventJoypadMotion):
		is_gamepad = true
		input_device_changed.emit(true)
