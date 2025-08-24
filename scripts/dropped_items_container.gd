extends Node2D

@export var is_shop: bool = true

func _enter_tree() -> void:
	var game_manager: GameManager = get_tree().root.get_node("GameUI/GameManager")
	if game_manager == null: return
	game_manager.register_container(is_shop, self)
