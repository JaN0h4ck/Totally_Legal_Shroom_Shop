extends Node2D

@export var basement_position : Node2D
@export var shop_position : Node2D

@export var shop_camera : Camera2D
@export var basement_camera : Camera2D

func _ready():
	EventBus.interact_basement.connect(teleport_basement)
	EventBus.interact_shop.connect(teleport_shop)

func teleport_basement():
	var player : Player = get_tree().get_first_node_in_group("player")
	player.position = basement_position.position
	
	shop_camera.enabled = false
	basement_camera.enabled = true

func teleport_shop():
	var player : Player = get_tree().get_first_node_in_group("player")
	player.position = shop_position.position
	
	basement_camera.enabled = false
	shop_camera.enabled = true
