@abstract class_name PickableRes extends Resource

## Globale Cinfig Ressource
var config : GlobalConfig = load("res://resources/global_config.tres")

## Das Standard Aussehen des Objektes
@export var base_texture : Texture2D
## Wie groß die Box ist in welcher der Spieler stehen muss um das Objekt aufzuheben
@export var interact_box_size : Vector2
## Wie lange es dauert das Objekt hochzuheben
var pickup_time : float = config.pickup_time

@export var rarity: GLOBALS.rarity
