extends PickableObject
class_name PickableCorpse

@export var corpse_res: CorpseRes

func prepare_item():
	var sprite : Sprite2D = Sprite2D.new()
	sprite.texture = corpse_res.base_texture
	add_child(sprite)
	set_collision_size()
	# Ändern der Anzeige mit was der Spieler interagieren kann
	interact_manager.interact_prompt = "Pick up Corpse"
	add_object_to_group("pickable_corpse")
	pickup_time = corpse_res.pickup_time

func set_collision_size(override_preset : bool = false, override_x: float = 0, override_y : float = 0):
	var rect_shape: RectangleShape2D = interact_collision.shape as RectangleShape2D
	if override_preset:
		rect_shape.size = Vector2(override_x, override_y) / 2
	else:
		rect_shape.size = corpse_res.interact_box_size / 2
	interact_collision.shape = rect_shape
