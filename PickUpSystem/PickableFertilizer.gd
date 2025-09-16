class_name PickableFertilizer
extends PickableObject

@export var fert_res : FertilizerRes

func prepare_item():
	var sprite : Sprite2D = Sprite2D.new()
	sprite.texture = fert_res.base_texture
	add_child(sprite)
	set_collision_size(true, 30, 30)
	interact_manager.interact_prompt = "Pick up Fertilizer"
	add_object_to_group("pickable_fertilizer")

## Legt die Größe der Collision Box fest auf die Werte aus dem ausgewähltem Objekt
func set_collision_size(override_preset : bool = false, override_x: float = 0, override_y : float = 0):
	var rect_shape: RectangleShape2D = interact_collision.shape as RectangleShape2D
	if override_preset:
		rect_shape.extents = Vector2(override_x, override_y) / 2
	else:
		rect_shape.extents = fert_res.interact_box_size / 2
	interact_collision.shape = rect_shape
