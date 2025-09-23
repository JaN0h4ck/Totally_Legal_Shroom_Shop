extends Interactable

## Globale Config Ressource
var config: GlobalConfig = load("res://resources/global_config.tres")

func check_if_player_has_corpse(player : Player):
	for child in player.object_place.get_children():
		if child.is_in_group("pickable_corpse"):
			return true
	return false

func player_has_enough_money():
	var needed_money : int = UpgradeSystem.calculate_upgrade_costs(config.first_upgrade_costs_crusher, config.upgrade_price_increase_crusher)
	return UpgradeSystem.check_if_player_has_enough_money(needed_money)

func _on_player_interacted():
	EventBus.crusher_upgrade.emit()

func _on_body_entered(body: Node2D):
	if(body.is_in_group(&"player")):
		var player: Player = body
		player_is_inside = true
		if(player.is_inside_interactable):
			player.interactable_queue.push_back(self)
			if(player.interactable_queue[0] == null):
				player.interactable_queue.pop_front()
				player.is_inside_interactable = false  # setter triggers validation proccess of queue
			return
		if check_if_player_has_corpse(player):
			return
		if not player_has_enough_money():
			return
		player_entered.emit(interact_prompt, name)
		player.is_inside_interactable = true
