extends Node2D

@onready var player_spawn: Node2D = $PlayerSpawn
@onready var player: Player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.interact_basement.connect(_on_basement_enable)
	EventBus.interact_shop.connect(_on_basement_disable)

func _on_basement_enable():
	player.position = player_spawn.position
	player.process_mode = Node.PROCESS_MODE_INHERIT

func _on_basement_disable():
	player.process_mode = Node.PROCESS_MODE_DISABLED
