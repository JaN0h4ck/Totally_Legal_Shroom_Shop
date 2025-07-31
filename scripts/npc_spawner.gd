extends Node2D

@onready var npc_cowboy := preload("res://Character/NPCs/cowboy_npc.tscn")
@onready var npc_angry := preload("res://Character/NPCs/angry_npc.tscn")
@onready var npc_conspiracy := preload("res://Character/NPCs/conspiracy_npc.tscn")
@onready var npc_alien := preload("res://Character/NPCs/alien_npc.tscn")
@onready var timer = $Timer

@export var spawn_timer_min : float = 5.0
@export var spawn_timer_max : float = 10.0

## Wie of Common NPCs im NPC Array vorkommen sollen damit sie heufiger spawnen
@export var number_common_npcs : int = 3
## Wie of Rare NPCs im NPC Array vorkommen sollen damit sie heufiger spawnen
@export var number_rare_npcs : int = 2

var npc_list : Array = []
var rng = RandomNumberGenerator.new()

func _ready():
	# Position auf 0 damit NPC nicht versetzt ist
	position = Vector2(0,0)
	
	# NPC Liste alle NPCs hinzufügen
	# Alle seltenen nur ein mal
	
	# Alle etwas seltene 2 mal
	for i in range (number_rare_npcs):
		pass
	
	# Alle normalen drei mal
	# Cowboy, Conspiracy, Angry
	for i in range (number_common_npcs):
		npc_list.append(npc_cowboy)
		npc_list.append(npc_angry)
		npc_list.append(npc_conspiracy)
		npc_list.append(npc_alien)
	
	
	# Spawn Timer Starten
	randomize_timer()
	
	# Spawn Timmer immer dann starten wenn NPC abgefertigt
	EventBus.npc_left_trapdoor.connect(randomize_timer)

func spawn_npc():
	var npc_to_spawn = npc_list.pick_random()
	var npc : base_npc = npc_to_spawn.instantiate()
	npc.position = position
	
	npc.path = get_tree().get_first_node_in_group("npc_path2D")
	npc.path_follow = get_tree().get_first_node_in_group("npc_followpath2D")
	
	npc.path_follow.progress = 0
	npc.position = npc.path.curve.get_point_position(0)
	
	add_child(npc)

func _on_timer_timeout():
	spawn_npc()

func randomize_timer():
	var rng = RandomNumberGenerator.new()
	var random_nummer = rng.randf_range(5.0, 10.0)
	timer.wait_time = random_nummer
	timer.start()
