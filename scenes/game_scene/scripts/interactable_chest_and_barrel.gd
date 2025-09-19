extends Interactable

func _ready():
	super()

func _on_player_interacted() -> void:
	EventBus.open_inventory.emit()
