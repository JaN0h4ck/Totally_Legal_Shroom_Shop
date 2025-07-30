extends Interactable

func _ready():
	player_interacted.connect(EventBus._on_interact_lever)
