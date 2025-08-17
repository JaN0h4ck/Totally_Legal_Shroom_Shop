extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var shop: SubViewportContainer = $Shop
@onready var basement: SubViewportContainer = $Basement
@onready var door_sound: AudioStreamPlayer = $DoorSound


func _ready():
	EventBus.interact_basement.connect(_teleport_basement)
	EventBus.interact_shop.connect(_teleport_shop)

func _teleport_basement():
	audio_stream_player.set("parameters/switch_to_clip", &"Basement")
	shop.visible = false
	basement.visible = true
	door_sound.play()

func _teleport_shop():
	audio_stream_player.set("parameters/switch_to_clip", &"Shop")
	basement.visible = false
	shop.visible = true
	door_sound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
