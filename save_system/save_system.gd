extends PauseMenu

var player : Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _save():
	var saved_game : SavedGame = SavedGame.new()
	# Variable auf Standard setzten
	saved_game.npc_saved = false
	saved_game.corpse_saved = false
	
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
	
	# Alles in Datei Schreiben
	ResourceSaver.save(saved_game, "user://savegame.tres")
	
	# Pause Menü Schließen
	close()


func _load():
	var saved_game : SavedGame = load("user://savegame.tres")
	
	player.global_position = saved_game.player_position
	
	if saved_game.player_in_shop:
		EventBus.load_shop.emit()
	else:
		EventBus.load_dungeon.emit()
	
	for npc in get_tree().get_nodes_in_group("npc"):
		npc.get_parent().remove_child(npc)
		npc.queue_free()
		EventBus.npc_left_shop.emit()
	
	if saved_game.npc_saved:
		var npc_spawner : NPC_Spawner = get_tree().get_first_node_in_group("npc_spawner")
		npc_spawner.load_npc(saved_game.npc_name, saved_game.npc_path_number, saved_game.npc_path_progress)
	
	for corpse in get_tree().get_nodes_in_group("corpse"):
		corpse.get_parent().remove_child(corpse)
		corpse.queue_free()
	
	if saved_game.corpse_saved:
		for corpse_info : Array in saved_game.corpse_info:
			EventBus.corpse_loaded.emit(corpse_info[0], corpse_info[1])
	
	close()
