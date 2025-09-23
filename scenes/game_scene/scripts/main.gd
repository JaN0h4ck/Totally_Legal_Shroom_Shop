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
	EventBus.load_dungeon.connect(load_basement)
	EventBus.load_shop.connect(load_shop)
	if SaveSystem.load_on_start:
		EventBus.load_game.emit()

func teleport_basement():
	var player : Player = get_tree().get_first_node_in_group("player")
	player.position = basement_position.position
	
	load_basement()

func teleport_shop():
	var player : Player = get_tree().get_first_node_in_group("player")
	player.position = shop_position.position
	
	load_shop()


func load_basement():
	audio_stream_player.set("parameters/switch_to_clip", &"Basement")
	$teleport_point_basement/BasementDoorAudio.play()
	
	shop_camera.enabled = false
	basement_camera.enabled = true
	shop_canvas.visible = false
	dungeon_canvas.visible = true

func load_shop():
	audio_stream_player.set("parameters/switch_to_clip", &"Shop")
	$teleport_point_shopt/ShopDoorAudio.play()
	
	basement_camera.enabled = false
	shop_camera.enabled = true
	dungeon_canvas.visible = false
	shop_canvas.visible = true

func cameraShop():
	shop_camera.enabled = true
	basement_camera.enabled = false
