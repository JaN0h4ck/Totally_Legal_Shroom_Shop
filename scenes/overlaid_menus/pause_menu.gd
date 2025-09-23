extends PauseMenu

func _ready() -> void:
	EventBus.close_pause_menu.connect(close_menu)

func close_menu():
	close()

func _on_save_button_pressed() -> void:
	EventBus.save_game.emit()

func _on_load_button_pressed() -> void:
	EventBus.load_game.emit()
