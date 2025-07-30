class_name DialogManager
extends Node

enum DialogTypes { GENERIC }

@export var ui_layer: Control
@export var dialogue_scene: PackedScene
@export var dialogue_file_path: String
var dialogue_panel: DialogPanel
var generic: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parse_json()

func parse_json():
	if FileAccess.file_exists(dialogue_file_path):
		var file = FileAccess.open(dialogue_file_path, FileAccess.READ)
		var file_string = file.get_as_text()
		var parser = JSON.new()
		var error = parser.parse(file_string)
		if(error == OK):
			var data_received = parser.data
			if typeof(data_received) == TYPE_DICTIONARY:
				generic = data_received.generic

func init_dialogue(type: DialogTypes):
	var instance = dialogue_scene.instantiate()
	ui_layer.add_child(instance)
	dialogue_panel = instance
