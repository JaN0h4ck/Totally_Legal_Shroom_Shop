extends Interactable

func _ready():
	super()

func _on_player_interacted():
	var parent : mushroom_spawn_system = get_parent()
	parent.spawn_mushroom_seed(global_position)
