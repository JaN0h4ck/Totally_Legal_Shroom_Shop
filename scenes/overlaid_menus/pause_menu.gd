extends PauseMenu

var player : CharacterBody2D

var save_path : String = "user://save_game.tres"
var save_group_name : String = "saveable"

func _save():
	var data = SceneData.new()
	
	# Spieler aus aktuellem Level holen
	player = get_tree().get_first_node_in_group("player")
	
	# Spielerpostion und Blickrichtung speichern
	data.player_position = player.global_position
	data.player_facing_left = player.get_child(0).flip_h
	
	# Alle Objekte aus Gruppe "saveable" speichern
	var savables = get_tree().get_nodes_in_group(save_group_name)
	for savable in savables:
		var saveable_scene = PackedScene.new()
		saveable_scene.pack(savable)
		data.saveable_array.append(saveable_scene)
	
	ResourceSaver.save(data, save_path)
	print("saved!")


func _load():
	var data = ResourceLoader.load(save_path) as SceneData
	
	# Spieler aus aktuellem Level holen
	player = get_tree().get_first_node_in_group("player")
	
	# Spieler Postion und Blickrichtung laden
	player.global_position = data.player_position
	player.get_child(0).flip_h = data.player_facing_left
	
	# Alle aktuellen Objekte aus "saveable" löschen
	for saveable in get_tree().get_nodes_in_group(save_group_name):
		saveable.queue_free()
	
	# Alle gespeicherten Objekte aus "saveable" erzeugen
	for saveable in data.saveable_array:
		var saveable_node = saveable.instantiate()
		get_tree().current_scene.add_child(saveable_node)
	
	print("loaded!")
