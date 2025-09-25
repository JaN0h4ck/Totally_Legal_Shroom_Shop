extends Control
# Close Inventory

func _ready() -> void:
	get_tree().paused = true

func _process(_delta: float) -> void:
	if(Input.is_action_pressed("ui_cancel") or Input.is_action_pressed("joy_cancel")):
		get_tree().paused = false
		self.queue_free()
