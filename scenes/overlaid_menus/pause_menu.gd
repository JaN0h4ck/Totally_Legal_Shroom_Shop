extends PauseMenu

var player : Player


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
# close() zum schließen


func _save():
	var saved_game : SavedGame = SavedGame.new()
	
	saved_game.npc_saved = false
	
	saved_game.player_position = player.global_position
	
	for npc in get_tree().get_nodes_in_group("npc"):
		saved_game.npc_name = npc.npc_name
		saved_game.npc_path_number = npc.path_number
		saved_game.npc_path_progress = npc.path_follow.progress
		saved_game.npc_saved = true
	
	ResourceSaver.save(saved_game, "user://savegame.tres")



func _load():
	var saved_game : SavedGame = load("user://savegame.tres")
	
	player.global_position = saved_game.player_position
	
	for npc in get_tree().get_nodes_in_group("npc"):
		npc.get_parent().remove_child(npc)
		npc.queue_free()
	
	if saved_game.npc_saved:
		var npc_spawner : NPC_Spawner = get_tree().get_first_node_in_group("npc_spawner")
		npc_spawner.load_npc(saved_game.npc_name, saved_game.npc_path_number, saved_game.npc_path_progress)
