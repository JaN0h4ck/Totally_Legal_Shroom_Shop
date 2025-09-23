extends Interactable

@onready var wood_chipper: crush_system = $".."
@onready var fertillizer_point: Node2D = $"../fertillizer_point"
@onready var interact_crusher: Interactable = $"."

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

func check_if_player_has_corpse(player : Player):
	for child in player.object_place.get_children():
		if child.is_in_group("pickable_corpse"):
			return true
	return false

func _on_player_interacted():
	wood_chipper.on_corpse_handed_over()

func _on_body_entered(body: Node2D):
	if(body.is_in_group(&"player")):
		var player: Player = body
		if(player.is_inside_interactable):
			player.interactable_queue.push_back(self)
			if(player.interactable_queue[0] == null):
				player.interactable_queue.pop_front()
				player.is_inside_interactable = false  # setter triggers validation proccess of queue
			return
		if not check_if_player_has_corpse(player):
			return
		player_is_inside = true
		player_entered.emit(interact_prompt, name)
		player.is_inside_interactable = true
