extends Interactable

@onready var wood_chipper: crush_system = $".."

func _ready():
	super()

func _on_player_interacted():
	wood_chipper.on_corpse_handed_over()
