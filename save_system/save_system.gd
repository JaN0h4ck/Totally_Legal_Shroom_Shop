extends Node

var player : Player
var save_path : String = "user://savegame.tres"
var load_on_start : bool = false

func _ready() -> void:
	EventBus.save_game.connect(save_game)
	EventBus.load_game.connect(load_game)

func save_game():
	player = get_tree().get_first_node_in_group("player")
	var saved_game : SavedGame = SavedGame.new()
	# Variable auf Standard setzten
	saved_game.npc_saved = false
	saved_game.corpse_saved = false
	saved_game.fertilizer_saved = false
	
	# Player Stuff speichern
	saved_game.player_position = player.global_position
	saved_game.player_in_shop = player.current_in_shop
	
	# Kunden Stuff speichern
	for npc in get_tree().get_nodes_in_group("npc"):
		saved_game.npc_name = npc.npc_name
		saved_game.npc_path_number = npc.path_number
		saved_game.npc_path_progress = npc.path_follow.progress
		saved_game.npc_saved = true
	
	# Leichen Stuff speichern
	for corpse in get_tree().get_nodes_in_group("corpse"):
		var corpse_info : Array = []
		corpse_info.append(corpse.corpse_res)
		corpse_info.append(corpse.global_position)
		saved_game.corpse_info.append(corpse_info)
		saved_game.corpse_saved = true
	
	# Dünger Stuff speichern
	for fertilizer in get_tree().get_nodes_in_group("fertilizer"):
		var fertilizer_info : Array = []
		fertilizer_info.append(fertilizer.fert_res)
		fertilizer_info.append(fertilizer.global_position)
		saved_game.fertilizer_info.append(fertilizer_info)
		saved_game.fertilizer_saved = true
	
	# Pilze Stuff speichern
	for mushroom in get_tree().get_nodes_in_group("Shroom"):
		var mushrrom_info : Array = []
		mushrrom_info.append(mushroom.shroom_res)
		mushrrom_info.append(mushroom.global_position)
		mushrrom_info.append(mushroom.global_rotation)
		mushrrom_info.append(mushroom.grow_stage)
		mushrrom_info.append(mushroom.in_inventory)
		mushrrom_info.append(mushroom.inventory_position)
		saved_game.mushroom_info.append(mushrrom_info)
		saved_game.mushroom_saved = true
	
	# Alles in Datei Schreiben
	ResourceSaver.save(saved_game, save_path)
	
	# Pause Menü Schließen
	EventBus.close_pause_menu.emit()


func load_game():
	if not FileAccess.file_exists(save_path):
		print("Save File not exists")
		return
	
	player = get_tree().get_first_node_in_group("player")
	var saved_game : SavedGame = load(save_path)
	
	# Spieler Sachen Setzen
	player.global_position = saved_game.player_position
	player.carries_object = false
	for children in player.object_place.get_children():
		player.object_place.remove_child(children)
	
	if saved_game.player_in_shop:
		EventBus.load_shop.emit()
		player.current_in_shop = true
	else:
		EventBus.load_dungeon.emit()
		player.current_in_shop = false
	
	# Aktuelle NPCs löschen
	for npc in get_tree().get_nodes_in_group("npc"):
		npc.get_parent().remove_child(npc)
		npc.queue_free()
		EventBus.npc_left_shop.emit()
	# Gespeicherte NPCs laden
	if saved_game.npc_saved:
		var npc_spawner : NPC_Spawner = get_tree().get_first_node_in_group("npc_spawner")
		npc_spawner.load_npc(saved_game.npc_name, saved_game.npc_path_number, saved_game.npc_path_progress)
	
	# Akutelle Leichen löschen
	for corpse in get_tree().get_nodes_in_group("corpse"):
		corpse.get_parent().remove_child(corpse)
		corpse.queue_free()
	# Gespeicherte Leichen laden
	if saved_game.corpse_saved:
		for corpse_info : Array in saved_game.corpse_info:
			EventBus.corpse_loaded.emit(corpse_info[0], corpse_info[1])
	
	# Aktuellen Dünger löschen
	for fertilizer in get_tree().get_nodes_in_group("fertilizer"):
		fertilizer.get_parent().remove_child(fertilizer)
		fertilizer.queue_free()
	# Gespeichernten Dünger laden
	if saved_game.fertilizer_saved:
		for fertilizer_info : Array in saved_game.fertilizer_info:
			EventBus.load_fertilizer.emit(fertilizer_info[0], fertilizer_info[1])
	
	# Aktuelle Pilze löschen
	for mushroom in get_tree().get_nodes_in_group("Shroom"):
		mushroom.get_parent().remove_child(mushroom)
		mushroom.queue_free()
	for mushroom in get_tree().get_nodes_in_group("pickable_mushroom"):
		mushroom.get_parent().remove_child(mushroom)
		mushroom.queue_free()
	# Gespeicherte Pilze laden
	if saved_game.mushroom_saved:
		for mushroom_info : Array in saved_game.mushroom_info:
			EventBus.load_mushroom.emit(mushroom_info[0], mushroom_info[1], mushroom_info[2], mushroom_info[3], mushroom_info[4], mushroom_info[5])
	
	# Inventar aktuallisieren
	EventBus.inventory_updated.emit()

	# Pause Menü Schließen
	EventBus.close_pause_menu.emit()
