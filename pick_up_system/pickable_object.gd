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
	if not is_pickable:
		print("Cant be picked right now")
		return
	
	print("player_interacted")
