extends Interactable

const _2D_OUTLINE: ShaderMaterial = preload("uid://5gys6hamkwkm")
const textures_path = "res://assets/dungeon/field/"

const textures: Array[CompressedTexture2D] = [
	preload("uid://bod53hly66uxh"),preload("uid://dsji1y625gubp"),preload("uid://nhsle6i3w1ta"),preload("uid://ch418vpo7mnvh"),
	preload("uid://kefye3y6xmjt"),preload("uid://dbv7rjqq7h073"),preload("uid://bg5fgayy4j8tn"),preload("uid://5ogr778x40ei"),
	preload("uid://dqxharekt6m2e"),preload("uid://k4h3c6lkv6x7"),preload("uid://ca378m63vayl7"),preload("uid://b66luvs300b8j")
]

var sprite: Sprite2D

func _ready():
	super()
	player_entered.connect(activate_outline)
	player_left.connect(remove_outline)
	sprite = Sprite2D.new()
	sprite.texture = textures[randi_range(0, textures.size()-1)]
	sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	add_child(sprite)

func activate_outline(_arg1, _arg2):
	sprite.material = _2D_OUTLINE

func remove_outline(_arg1):
	sprite.material = null

func _on_player_interacted():
	var parent : mushroom_spawn_system = get_parent()
	parent.spawn_mushroom_seed(global_position)
