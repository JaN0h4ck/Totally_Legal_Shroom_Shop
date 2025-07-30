class_name GameManager
extends Node

@onready var ui_layer: Control = $"../UILayer"
@export var interact_scene: PackedScene
@export var pause_scene: PackedScene

var is_paused: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action("ui_cancel"):
		if not is_paused:
			is_paused = true
			var instance: PauseMenu = pause_scene.instantiate()
			get_parent().add_child(instance)
			get_viewport().set_input_as_handled()
		else:
			is_paused = false

func show_interact_prompt(prompt: String):
	var instance: InputPrompt = interact_scene.instantiate()
	instance.text = prompt
	instance.action_name = "interact"
	instance.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
	ui_layer.add_child(instance)

func destroy_interact_prompt():
	$"../UILayer/InputPrompt".queue_free()
