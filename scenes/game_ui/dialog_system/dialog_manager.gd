class_name DialogManager
extends Node

enum DialogTypes { GENERIC }

@export var ui_layer: Control
@export var dialogue_scene: PackedScene
var dialogue_panel: DialogPanel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func init_dialogue(type: DialogTypes):
	var instance = dialogue_scene.instantiate()
	ui_layer.add_child(instance)
	dialogue_panel = instance
