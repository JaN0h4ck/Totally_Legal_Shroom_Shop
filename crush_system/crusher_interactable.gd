extends Interactable

@onready var wood_chipper: crush_system = $".."
@onready var fertillizer_point: Node2D = $"../fertillizer_point"

var new_parent

func _ready():
	super()

func _physics_process(_delta: float):
	var fertilizer_nodes = get_tree().get_nodes_in_group("pickable_fertilizer")
	for node : Node2D in fertilizer_nodes:
		if node.global_position == fertillizer_point.global_position:
			new_parent = get_tree().get_first_node_in_group("paused_nodes")
		else:
			new_parent = get_tree().get_first_node_in_group("wood_chipper")
		call_deferred("reparent", new_parent, false)

func _on_player_interacted():
	wood_chipper.on_corpse_handed_over()
