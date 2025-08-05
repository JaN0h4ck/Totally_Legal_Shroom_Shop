class_name DialogManager
extends Node

enum DialogTypes { GENERIC }

@export var ui_layer: CanvasLayer
@export var dialogue_scene: PackedScene
@export var dialogue_file_path: String

var dialogue_panel: DialogPanel
var generic: Array
var basic_shrooms: Array
var rare_shrooms: Array
var ultra_rare_shrooms: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	parse_json()
	EventBus.interact_customer.connect(start_npc_dialogue)
	EventBus.dialog_ended.connect(_on_dialogue_ended)

func start_npc_dialogue(npc: base_npc):
	if dialogue_panel != null: return
	var instance = dialogue_scene.instantiate()
	ui_layer.add_child(instance)
	dialogue_panel = instance
	dialogue_panel.portrait.texture = npc.portrait
	dialogue_panel._start_dialog(npc.lines[randi() % npc.lines.size()])

func start_random_dialogue():
	init_dialogue_deprec(DialogTypes.GENERIC)

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
				basic_shrooms = data_received.basic_shrooms
				rare_shrooms = data_received.rare_shrooms
				ultra_rare_shrooms = data_received.ultra_rare
		else:
			push_error("Dialogue JSON not valid")
			queue_free()

## DEPRECATED leaving this for debug reasons
func init_dialogue_deprec(type: DialogTypes):
	if dialogue_panel != null: return
	var instance = dialogue_scene.instantiate()
	ui_layer.add_child(instance)
	dialogue_panel = instance
	match type:
		DialogTypes.GENERIC:
			var line: String = generic[randi() % generic.size()] % [randi() % 2, basic_shrooms[randi() % basic_shrooms.size()]]
			dialogue_panel._start_dialog(line)

func _on_dialogue_ended():
	dialogue_panel = null
