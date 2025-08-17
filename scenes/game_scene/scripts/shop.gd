extends Sprite2D

@onready var player_spawn: Node2D = $PlayerSpawn
@onready var player: Player = $Player

func _ready() -> void:
	EventBus.interact_basement.connect(_on_shop_disable)
	EventBus.interact_shop.connect(_on_shop_enable)

func _on_shop_enable():
	player.position = player_spawn.position
	player.process_mode = Node.PROCESS_MODE_INHERIT

func _on_shop_disable():
	player.process_mode = Node.PROCESS_MODE_DISABLED
