extends Node2D

@export var basement_position : Node2D
@export var shop_position : Node2D

@export var shop_camera : Camera2D
@onready var shop_canvas: CanvasModulate = $shop/ShopCanvas
@export var basement_camera : Camera2D
@onready var dungeon_canvas: CanvasModulate = $Dungeon/DungeonCanvas

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	EventBus.interact_basement.connect(teleport_basement)
	EventBus.interact_shop.connect(teleport_shop)

func teleport_basement():
	audio_stream_player.set("parameters/switch_to_clip", &"Basement")
	$teleport_point_basement/BasementDoorAudio.play()
	var player : Player = get_tree().get_first_node_in_group("player")
	player.position = basement_position.position
	
	shop_camera.enabled = false
	basement_camera.enabled = true
	shop_canvas.visible = false
	dungeon_canvas.visible = true

func teleport_shop():
	audio_stream_player.set("parameters/switch_to_clip", &"Shop")
	$teleport_point_shopt/ShopDoorAudio.play()
	var player : Player = get_tree().get_first_node_in_group("player")
	player.position = shop_position.position
	
	basement_camera.enabled = false
	shop_camera.enabled = true
	dungeon_canvas.visible = false
	shop_canvas.visible = true

func cameraShop():
	shop_camera.enabled = true
	basement_camera.enabled = false
