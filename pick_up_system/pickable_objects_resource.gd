extends Resource
class_name pickable_object_resource

## Globale Cinfig Ressource
var config : GlobalConfig = load("res://resources/global_config.tres")

## Das Standard Aussehen des Objektes
@export var base_texture : Texture2D
## Wie groß die Box ist in welcher der Spieler stehen muss um das Objekt aufzuheben
@export var interact_box_size : Vector2
## Wie lange es dauert das Objekt hochzuheben
var pickup_time : float = config.pickup_time

enum rarity_enum {common, rare, ultra_rare}
@export var rarity: rarity_enum
