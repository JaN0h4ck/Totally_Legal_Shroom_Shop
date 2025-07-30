extends Interactable

func _ready():
	super()
	EventBus.interact_lever.emit()
