extends Node2D
class_name pickable_object

## Um was für ein pickable_object es sich handelt
@export var selected_object : pickable_object_resource

## Collision Shape in welcher der Spieler zum Interagieren stehen muss
@onready var interact_collision: CollisionShape2D = $interact_object/interact_collision

## True wenn es ein Pilz ist
var is_mushroom : bool = false
## True wenn Objekt mommentan aufgehoben werden kann
var is_pickable : bool = true

func _ready() -> void:
	set_collision_size()
	check_slected_object_type()
	
	if is_mushroom:
		pass
	else:
		create_corpse()

## Überprüft ob das ausgewählte Objekt ein Pilz ist
func check_slected_object_type():
	if selected_object is pickable_mushroom_resource:
		is_mushroom = true
	else:
		is_mushroom = false

## Legt die Größe der Collision Box fest auf die Werte aus dem ausgewähltem Objekt
func set_collision_size():
	interact_collision.shape.get_rect().size.x = selected_object.interact_box_size.x
	interact_collision.shape.get_rect().size.y = selected_object.interact_box_size.y

## Erstellte eine Sprite2D mit dem aussehen der Leiche
func create_corpse():
	var sprite : Sprite2D = Sprite2D.new()
	sprite.texture = selected_object.base_texture
	add_child(sprite)

func create_mushroom():
	var base_sprite : Sprite2D


func _on_player_interacted() -> void:
	pass # Replace with function body.
