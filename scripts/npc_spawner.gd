extends Node2D
class_name NPC_Spawner

@onready var npc_cowboy := preload("res://Character/NPCs/cowboy_npc.tscn")
@onready var npc_angry := preload("res://Character/NPCs/angry_npc.tscn")
@onready var npc_conspiracy := preload("res://Character/NPCs/conspiracy_npc.tscn")
@onready var npc_alien := preload("res://Character/NPCs/alien_npc.tscn")
@onready var npc_cook := preload("res://Character/NPCs/cook_npc.tscn")
@onready var npc_beff := preload("res://Character/NPCs/beff_npc.tscn")
@onready var npc_celebrity := preload("res://Character/NPCs/celebrity_npc.tscn")
@onready var npc_enthusiast := preload("res://Character/NPCs/enthusiast_npc.tscn")
@onready var npc_nerd := preload("res://Character/NPCs/nerd_npc.tscn")
@onready var npc_grandpa := preload("res://Character/NPCs/grandpa_npc.tscn")
@onready var timer = $Timer

@export var spawn_timer_min : float = 3.0
@export var spawn_timer_max : float = 6.0

## Wie of Common NPCs im NPC Array vorkommen sollen damit sie heufiger spawnen
@export var number_common_npcs : int = 3
## Wie of Rare NPCs im NPC Array vorkommen sollen damit sie heufiger spawnen
@export var number_rare_npcs : int = 2
## Wie of Ultra Rare NPCs im NPC Array vorkommen sollen damit sie seltener spawnen
@export var number_ultra_rare_npcs : int = 1

var npc_list : Array = []
var npc_in_shop : bool = false

func _ready():
	# Position auf 0 damit NPC nicht versetzt ist
	position = Vector2(0,0)
	
	# NPCs zu Spawn Array hinzufügen
	add_npc(npc_cowboy)
	add_npc(npc_angry)
	add_npc(npc_conspiracy)
	add_npc(npc_alien)
	add_npc(npc_cook)
	add_npc(npc_beff)
	add_npc(npc_celebrity)
	add_npc(npc_enthusiast)
	add_npc(npc_nerd)
	add_npc(npc_grandpa)
	
	
	# Spawn Timer Starten
	timer.one_shot = true
	timer.autostart = false
	randomize_timer()
	
	# Spawn Timmer immer dann starten wenn NPC abgefertigt
	EventBus.npc_left_trapdoor.connect(randomize_timer)
	EventBus.npc_left_shop.connect(npc_left)
	EventBus.npc_dropped.connect(npc_with_name_left)

func add_npc(npc):
	var npc_instance = npc.instantiate()
	match npc_instance.rarity:
		GLOBALS.rarity.common:
			for i in range (number_common_npcs):
				npc_list.append(npc)
		GLOBALS.rarity.rare:
			for i in range (number_rare_npcs):
				npc_list.append(npc)
		GLOBALS.rarity.ultra_rare:
			for i in range (number_ultra_rare_npcs):
				npc_list.append(npc)
	npc_instance.queue_free()

func spawn_npc():
	if npc_in_shop == true:
		return
	
	npc_in_shop = true
	var npc_to_spawn = npc_list.pick_random()
	var npc : base_npc = npc_to_spawn.instantiate()
	npc.position = position
	
	var picked_paths = random_path()
	npc.path = picked_paths[0]
	npc.path_follow = picked_paths[1]
	
	npc.path_follow.progress = 0
	npc.position = npc.path.curve.get_point_position(0)
	
	add_child(npc)

## Wenn Save Game mit NPC geladen wird
func load_npc(npc_name : GLOBALS.npc_names):
	npc_in_shop = true
	var npc_to_spawn
	match npc_name:
		GLOBALS.npc_names.alien:
			npc_to_spawn = npc_alien
		GLOBALS.npc_names.angry:
			npc_to_spawn = npc_angry
		GLOBALS.npc_names.beff:
			npc_to_spawn = npc_beff
		GLOBALS.npc_names.celeb:
			npc_to_spawn = npc_celebrity
		GLOBALS.npc_names.conspiracy:
			npc_to_spawn = npc_conspiracy
		GLOBALS.npc_names.cook:
			npc_to_spawn = npc_cook
		GLOBALS.npc_names.cowboy:
			npc_to_spawn = npc_cowboy
		GLOBALS.npc_names.enthusiast:
			npc_to_spawn = npc_enthusiast
		GLOBALS.npc_names.nerd:
			npc_to_spawn = npc_nerd
		GLOBALS.npc_names.opa:
			npc_to_spawn = npc_grandpa
		_:
			npc_to_spawn = npc_cowboy
	
	var npc : base_npc = npc_to_spawn.instantiate()
	
	var picked_paths = random_path()
	npc.path = picked_paths[0]
	npc.path_follow = picked_paths[1]
	
	npc.path_follow.progress = 0.0
	
	add_child(npc)


func _on_timer_timeout():
	spawn_npc()

func randomize_timer():
	var rng = RandomNumberGenerator.new()
	var random_nummer = rng.randf_range(5.0, 10.0)
	timer.wait_time = random_nummer
	timer.one_shot = false
	timer.stop()
	timer.start()

func random_path():
	var follow_path = get_tree().get_nodes_in_group("npc_followpath2D")
	var path2d = get_tree().get_nodes_in_group("npc_path2D")
	
	var lenght = follow_path.size()
	
	var rng = RandomNumberGenerator.new()
	var random_nummer = rng.randi_range(0, lenght-1)
	
	return [path2d[random_nummer], follow_path[random_nummer]]

func npc_left():
	npc_in_shop = false

func npc_with_name_left(_npc_name):
	npc_in_shop = false
