extends Interactable

var is_blocked: bool = true

func _ready():
	super()
	EventBus.npc_entered_trapdoor.connect(_on_enter_trapdoor)
	EventBus.npc_left_trapdoor.connect(_on_left_trapdoor)

func _on_enter_trapdoor():
	is_blocked = false
	if(player_is_inside):
		player_entered.emit(interact_prompt, name)

func _on_left_trapdoor():
	is_blocked = true
	if(player_is_inside):
		player_left.emit(name)

func _on_body_entered(body: Node2D):
	if body.is_in_group(&"player"):
		player_is_inside = true
	if is_blocked: return
	super(body)

func _on_body_exited(body: Node2D):
	if body.is_in_group(&"player"):
		player_is_inside = false
	if is_blocked: return
	super(body)

func _on_player_interacted():
	EventBus.interact_customer.emit()
