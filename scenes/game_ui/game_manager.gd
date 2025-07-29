class_name GameManager
extends Node

@onready var ui_layer: Control = $"../UILayer"
@export var interact_scene: PackedScene

func show_interact_prompt(prompt: String):
	var instance: InputPrompt = interact_scene.instantiate()
	instance.text = prompt
	instance.action_name = "interact"
	instance.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
	ui_layer.add_child(instance)

func destroy_interact_prompt():
	$"../UILayer/InputPrompt".queue_free()
