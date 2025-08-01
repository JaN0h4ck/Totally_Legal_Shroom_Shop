extends Resource
class_name pickable_objects

## Das Standard Aussehen des Objektes
@export var base_texture : Texture2D
## Wie groß die Box ist in welcher der Spieler stehen muss um das Objekt aufzuheben
@export var interact_box_size : Vector2
## Wie lange es dauert das Objekt hochzuheben
@export var pickup_time : float = 1.0
