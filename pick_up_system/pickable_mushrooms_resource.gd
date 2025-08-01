extends pickable_objects
class_name pickable_mushrooms

## Texture wenn der Pilz zur hälfte gewachsen ist
@export var middle_stage_texture : Texture2D
## Texture wenn der Pilz voll ausgewachsen ist
@export var end_stage_texture : Texture2D
## Wie lange der Pilz braucht um zur hälfte gewachsen zu sein
@export var grow_time_middle : float = 1.0
## Wie lange der Pilz braucht um vom mittleren ins end stdium zu wachsen
@export var grow_time_end : float = 1.0
