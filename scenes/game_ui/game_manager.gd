class_name GameManager
extends Node

@onready var ui_layer: CanvasLayer = $"../UILayer"
@export var interact_scene: PackedScene
@export var pause_scene: PackedScene
@export var inv_scene: PackedScene
@export var lexicon_scene: PackedScene
var container_shop: Node2D
var container_dungeon: Node2D

var is_paused: bool = false
var is_in_shop: bool = false

func _ready() -> void:
	EventBus.open_inventory.connect(_on_open_inventory)
	EventBus.interact_lexikon.connect(_on_open_lexikon)
	EventBus.interact_shop.connect(_on_enter_shop)
	EventBus.interact_basement.connect(_on_enter_basement)

func register_container(is_shop: bool, container: Node2D):
	if is_shop:
		container_shop = container
	else:
		container_dungeon = container

func _on_enter_shop():
	is_in_shop = true

func _on_enter_basement():
	is_in_shop = false

func _on_open_inventory():
	var instance = inv_scene.instantiate()
	ui_layer.add_child(instance)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if not is_paused:
			is_paused = true
			var instance: PauseMenu = pause_scene.instantiate()
			get_parent().add_child(instance)
			get_viewport().set_input_as_handled()
		else:
			is_paused = false

func show_interact_prompt(prompt: String, interactable_name: String):
	var instance: InputPrompt = interact_scene.instantiate()
	instance.text = prompt
	instance.action_name = "interact"
	instance.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
	instance.interactable_name = interactable_name
	ui_layer.add_child(instance)

func destroy_interact_prompt(interactable_name: String):
	var nodes: Array[Node] = get_tree().get_nodes_in_group("input_prompt")
	for node in nodes:
		if node.interactable_name == interactable_name: 
			node.queue_free()

func _on_open_lexikon():
	var instance = lexicon_scene.instantiate()
	ui_layer.add_child(instance)
