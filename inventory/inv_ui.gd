@tool
extends OverlaidMenu

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		close()
