extends Node2D
class_name pickable_object

## Um was für ein pickable_object es sich handelt
@export var selected_object : pickable_object_resource

## Collision Shape in welcher der Spieler zum Interagieren stehen muss
@onready var interact_collision: CollisionShape2D = $interact_object/interact_collision
## Objekte welches das Interagieren des Spielers abgreift
@onready var interact_manager: Interactable = $interact_object

## True wenn Objekt mommentan aufgehoben werden kann
var is_pickable : bool = true
var is_picked : bool = false
## True wenn der Spieler das Objekt irgendwo im Level abgelegt hat
var is_random_dropped : bool = false

func _ready():
	EventBus.drop_object.connect(drop_object)
	# Fügt das Objekt der passenden Gruppe hinzu
	if selected_object is pickable_mushroom_resource:
		self.add_to_group("pickable_mushroom")
	else:
		self.add_to_group("pickable_corpse")

## Erstellte die nötigen Sachen für einen Pilz
func create_mushroom():
	is_pickable = false
	var sprite : Sprite2D = Sprite2D.new()
	sprite.texture = selected_object.base_texture
	add_child(sprite)
	set_collision_size()
	# Ändern der Anzeige mit was der Spieler interagieren kann
	interact_manager.interact_prompt = "Interact Mushroom"
	mushroom_grow(sprite)

## Erstellte eine Sprite2D mit dem aussehen der Leiche
func create_corpse():
	var sprite : Sprite2D = Sprite2D.new()
	sprite.texture = selected_object.base_texture
	add_child(sprite)
	set_collision_size()
	# Ändern der Anzeige mit was der Spieler interagieren kann
	interact_manager.interact_prompt = "Interact Corpse"

## Legt die Größe der Collision Box fest auf die Werte aus dem ausgewähltem Objekt
func set_collision_size():
	var rect_shape = interact_collision.shape as RectangleShape2D
	rect_shape.extents = selected_object.interact_box_size / 2
	interact_collision.shape = rect_shape

## Was passieren soll wenn der Spieler mit dem Objekt interagiert
func _on_player_interacted() -> void:
	if not is_pickable or is_picked:
		print("Cant be picked right now")
		return
	add_to_player()

## Objekt auf den Spieler Kopf legen
func add_to_player():
	EventBus.pickup_object.emit(global_position, is_random_dropped)
	var player : Player = get_tree().get_first_node_in_group("player")
	# Schauen ob Spieler bereits ein Objekt trägt
	if player.carries_object:
		print("Player is already carring an object")
		return
	# Objekt zum Spieler hinzufügen
	self.reparent(player.object_place, true)
	player.carries_object = true
	# Position des Objekts auf die neue Position durch eine Bewegung setzten
	animated_movement(Vector2(0,0))
	# Dafür sorgen dass es nicht doppelt aufgehoben werden kann
	is_picked = true
	set_collision_size_to_zero()
	is_random_dropped = false

## Setzt die Größe der Interact Collision auf Null
func set_collision_size_to_zero():
	var zero_shape = interact_collision.shape as RectangleShape2D
	zero_shape.extents = Vector2(0,0)
	interact_collision.shape = zero_shape

## Bewegt das aufgehobene Objekt zum Spieler
func animated_movement(target : Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", target, selected_object.pickup_time).from_current()

## Funktion um den Pilz über Zeit wachsen zu lassen, braucht das Sprite welches das Pilz bild anzeigt
func mushroom_grow(sprite : Sprite2D):
	# Erstellen eines Timers
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = selected_object.grow_time_middle
	timer.one_shot = true
	timer.autostart = false
	timer.start()
	# Warten bis Timer fertig ist
	await timer.timeout
	sprite.texture = selected_object.middle_stage_texture
	# Timer neu einstellen und starten
	timer.wait_time = selected_object.grow_time_end
	timer.start()
	# Warten bis zwiter Timer fertig ist
	await timer.timeout
	sprite.texture = selected_object.end_stage_texture
	# Einstellen das Pilz ab jetzt aufgehoben werden kann
	is_pickable = true

## Objekt fallen lassen
func drop_object():
	if not is_picked:
		return
	is_random_dropped = true
	set_collision_size()
	is_picked = false
	var new_parent = get_tree().get_first_node_in_group("dropped_items_container")
	self.reparent(new_parent, true)
	throw_object(20)

## Wirft das Objekt in die Blickrichtung des Spielers
func throw_object(lenght : float):
	var player : Player = get_tree().get_first_node_in_group("player")
	var player_locking_direction = player.last_direction
	match player_locking_direction:
		player.Directions.FRONT:
			animated_movement(position + Vector2(0,lenght))
		player.Directions.BACK:
			animated_movement(position + Vector2(0,lenght))
		player.Directions.RIGHT:
			animated_movement(position + Vector2(lenght,lenght))
		player.Directions.LEFT:
			animated_movement(position + Vector2(-lenght,lenght))
