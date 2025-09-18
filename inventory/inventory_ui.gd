extends Control
# Close Inventory
func _process(_delta: float) -> void:
	if(Input.is_action_pressed("ui_cancel")):
		self.queue_free()
