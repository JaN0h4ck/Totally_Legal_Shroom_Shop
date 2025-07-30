extends Interactable

func _ready():
	super()
	player_interacted.connect(EventBus._on_interact_lever)
