extends Control

@onready var keyboard_prompt: InputPrompt = $KeyboardPrompt
@onready var joy_prompt: InputPrompt = $JoyPrompt

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display_prompt(InputDeviceMonitor.is_gamepad)
	InputDeviceMonitor.input_device_changed.connect(display_prompt)

func display_prompt(is_gamepad: bool):
	if is_gamepad:
		keyboard_prompt.visible = false
		joy_prompt.visible = true
	else:
		keyboard_prompt.visible = true
		joy_prompt.visible = false
