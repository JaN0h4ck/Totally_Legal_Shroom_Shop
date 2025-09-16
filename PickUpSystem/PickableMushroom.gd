extends PickableObject
class_name PickableMushroom

@export var shroom_res: ShroomRes

## Render Texture and add to corresponding Group
func prepare_item():
	is_pickable = false
	var sprite : Sprite2D = Sprite2D.new()
	sprite.texture = shroom_res.base_texture
	add_child(sprite)
	set_collision_size()
	# Ändern der Anzeige mit was der Spieler interagieren kann
	interact_manager.interact_prompt = "Pick up Mushroom"
	mushroom_grow(sprite)
	add_object_to_group("pickable_mushroom")

## Legt die Größe der Collision Box fest auf die Werte aus dem ausgewähltem Objekt
func set_collision_size(override_preset : bool = false, override_x: float = 0, override_y : float = 0):
	var rect_shape: RectangleShape2D = interact_collision.shape as RectangleShape2D
	if override_preset:
		rect_shape.extents = Vector2(override_x, override_y) / 2
	else:
		rect_shape.extents = shroom_res.interact_box_size / 2
	interact_collision.shape = rect_shape

## Funktion um den Pilz über Zeit wachsen zu lassen, braucht das Sprite welches das Pilz bild anzeigt
func mushroom_grow(sprite : Sprite2D):
	# Erstellen eines Timers
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = shroom_res.grow_time_middle
	timer.one_shot = true
	timer.autostart = false
	timer.start()
	# Warten bis Timer fertig ist
	await timer.timeout
	sprite.texture = shroom_res.middle_stage_texture
	# Timer neu einstellen und starten
	timer.wait_time = shroom_res.grow_time_end
	timer.start()
	# Warten bis zwiter Timer fertig ist
	await timer.timeout
	sprite.texture = shroom_res.end_stage_texture
	# Einstellen das Pilz ab jetzt aufgehoben werden kann
	is_pickable = true
