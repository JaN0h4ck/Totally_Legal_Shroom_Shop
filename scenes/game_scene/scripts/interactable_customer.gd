extends Interactable

var is_blocked: bool = true
var npc: base_npc

func _ready():
	super()
	EventBus.npc_entered_trapdoor.connect(_on_enter_trapdoor)
	EventBus.npc_left_trapdoor.connect(_on_left_trapdoor)
	EventBus.npc_dropped.connect(_on_dropped_from_trapdoor)

func _on_enter_trapdoor(_npc: base_npc):
	npc = _npc
	is_blocked = false
	if(player_is_inside):
		player_entered.emit(interact_prompt, name)

func _on_left_trapdoor():
	npc = null
	is_blocked = true
	if(player_is_inside):
		player_left.emit(name)

func _on_dropped_from_trapdoor(_npc_name : base_npc.npc_name_enum):
	_on_left_trapdoor()

func _on_body_entered(body: Node2D):
	if body.is_in_group(&"player"):
		player_is_inside = true
	if is_blocked: return
	super(body)

func _on_body_exited(body: Node2D):
	if body.is_in_group(&"player"):
		player_is_inside = false
	super(body)

func _input(event: InputEvent) -> void:
	if is_blocked: return
	super(event)

func _on_player_interacted():
	EventBus.interact_customer.emit(npc)
