class_name SavedGame
extends Resource

@export var player_position : Vector2
@export var player_in_shop : bool

@export var npc_saved : bool
@export var npc_name : GLOBALS.npc_names
@export var npc_path_number : int
@export var npc_path_progress : float

@export var corpse_saved : bool
@export var corpse_info : Array = []

@export var fertilizer_saved : bool
@export var fertilizer_info : Array = []

@export var mushroom_saved : bool
## Pilz Info in folgender Rheinfolge: Resource, Position, Rotation, Wachstumsstadium, Ob aktuell im Inventar, Inventarposition
@export var mushroom_info : Array = []
