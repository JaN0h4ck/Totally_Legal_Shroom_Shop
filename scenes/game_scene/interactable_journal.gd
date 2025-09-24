extends Interactable

func _ready():
	super()

func _on_player_interacted():
	EventBus.interact_journal.emit()
