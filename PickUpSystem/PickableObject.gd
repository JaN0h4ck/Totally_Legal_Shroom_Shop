@abstract class PickableObject extends Node2D:
	## Collision Shape in welcher der Spieler zum Interagieren stehen muss
	@onready var interact_collision: CollisionShape2D = $interact_object/interact_collision
	## Objekte welches das Interagieren des Spielers abgreift
	@onready var interact_manager: Interactable = $interact_object
	## Globale Cinfig Ressource
	var config : GlobalConfig = load("res://resources/global_config.tres")

	## True wenn Objekt mommentan aufgehoben werden kann
	var is_pickable : bool = true
	var is_picked : bool = false
	## True wenn der Spieler das Objekt irgendwo im Level abgelegt hat
	var is_random_dropped : bool = false
	## Load from res on ready
	var pickup_time

	#TODO check for collision to be there
	func _get_configuration_warnings() -> PackedStringArray:
		return []
	
	func _ready():
		EventBus.drop_object.connect(drop_object)
		prepare_item()
		set_collision_size()

	## Fügt Note und Interact Area zur eingegebenen Gruppe hinzu
	func add_object_to_group(group : String):
		self.add_to_group(group)
		interact_manager.add_to_group(group)
	
	## Render Texture and add to corresponding Group
	@abstract func prepare_item()

	## Legt die Größe der Collision Box fest auf die Werte aus dem ausgewähltem Objekt
	@abstract func set_collision_size(override_preset : bool = false, override_x: float = 0, override_y : float = 0)

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
		if player.carries_object and config.player_carry_only_one_item:
			print("Player is already carring an object")
			return
		# Objekt zum Spieler hinzufügen
		self.reparent(player.object_place, true)
		player.carries_object = true
		# Position des Objekts auf die neue Position durch eine Bewegung setzten
		pick_up_animation(Vector2(0,0))
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
	func pick_up_animation(target : Vector2):
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", target, pickup_time).from_current()

	## Objekt fallen lassen
	func drop_object():
		if not is_picked:
			return
		is_random_dropped = true
		set_collision_size(false, 0, 0)
		is_picked = false
		var new_parent = get_tree().get_first_node_in_group("dropped_items_container")
		self.reparent(new_parent, true)
		throw_object(20)

	## Objekt in den Schredder werfen
	func crush_object():
		is_random_dropped = false
		var player : Player = get_tree().get_first_node_in_group("player")
		player.carries_object = false
		var new_parent = get_tree().get_first_node_in_group("dropped_items_container")
		self.reparent(new_parent, true)

	## Wirft das Objekt in die Blickrichtung des Spielers
	func throw_object(length : float):
		var player : Player = get_tree().get_first_node_in_group("player")
		var player_locking_direction = player.last_direction
		match player_locking_direction:
			GLOBALS.directions.FRONT:
				pick_up_animation(position + Vector2(0,length))
			GLOBALS.directions.BACK:
				pick_up_animation(position + Vector2(0,length))
			GLOBALS.directions.RIGHT:
				pick_up_animation(position + Vector2(length,length))
			GLOBALS.directions.LEFT:
				pick_up_animation(position + Vector2(-length,length))
