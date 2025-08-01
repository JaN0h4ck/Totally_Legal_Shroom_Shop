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
	var player : Player = get_tree().get_first_node_in_group("player")
	# Schauen ob Spieler bereits ein Objekt trägt
	if player.carries_object:
		print("Player is already carring an object")
		return
	# Aktuelle Position Speichern
	var old_position : Vector2 = global_position
	# Objekt zum Spieler hinzufügen
	get_parent().remove_child(self)
	player.object_place.add_child(self)
	player.carries_object = true
	# Setzen der Position auf die alte Position, damit gleich Position durch eine "Animation" getauscht wird
	global_position = old_position
	# Position des Objekts auf die neue Position durch eine Bewegung setzten
	animated_movement(Vector2(0,0))
	# Dafür sorgen dass es nicht doppelt aufgehoben werden kann
	is_picked = true
	set_collision_size_to_zero()

## Setzt die Größe der Interact Collision auf Null
func set_collision_size_to_zero():
	var zero_shape = interact_collision.shape as RectangleShape2D
	zero_shape.extents = Vector2(0,0)
	interact_collision.shape = zero_shape

func animated_movement(target : Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", target, selected_object.pickup_time).from_current()
