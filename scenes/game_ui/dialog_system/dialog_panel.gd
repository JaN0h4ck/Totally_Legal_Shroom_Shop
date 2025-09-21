class_name DialogPanel
extends Control

@onready var label: Label = $VBoxContainer/HBoxContainer2/DialogPanel/MarginContainer/Label
@export var speed_char_ps: float = 32.0
var tween: Tween
@onready var dialog_audio: DialogAudio = $DialogAudio
@onready var portrait: TextureRect = $VBoxContainer/HBoxContainer/PortraitContainer/MarginContainer/Portrait

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(label == null):
		push_error("Label component missing in Dialog Panel")
		queue_free()
		return
	EventBus.dialog_started.emit()
	EventBus.order_complete.connect(_order_complete)

func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("skip_dialogue"):
		if not event.is_action_pressed("interact"):
			return
	if event.is_action_pressed("skip_dialogue"):
		if tween and tween.is_valid(): 
			_on_display_finished()
			tween.kill()
			label.visible_characters = -1
			get_viewport().set_input_as_handled()
		else: 
			get_viewport().set_input_as_handled()
			EventBus.dialog_ended.emit()
			queue_free()
	if event.is_action_pressed("interact"):
		EventBus.start_shopping.emit()

func _start_dialog(text: String):
	label.text = text
	var seconds: float = float(text.length()) / speed_char_ps
	if tween and tween.is_valid(): tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(label, "visible_characters", text.length(), seconds).from(0)
	tween.finished.connect(_on_display_finished)
	dialog_audio.start_playback(DialogAudio.VoiceTypes.MEDIUM)

func _on_display_finished():
	dialog_audio.stop_playback()

func _order_complete():
	get_viewport().set_input_as_handled()
	EventBus.dialog_ended.emit()
	queue_free()
