extends Panel

@onready var label: Label = $Label
@export var speed_char_ps: float = 32.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _start_dialog(text: String):
	label.text = text
	var seconds: float = float(text.length()) / speed_char_ps
	var tween = get_tree().create_tween()
	tween.tween_property(label, "visible_characters", text.length(), seconds).from(0)
