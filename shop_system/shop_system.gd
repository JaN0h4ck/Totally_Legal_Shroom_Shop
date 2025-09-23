extends Node

## Globale Config Ressource
var config: GlobalConfig = load("res://resources/global_config.tres")

func _ready() -> void:
	EventBus.sell_mushroom.connect(sell_mushroom)

func sell_mushroom(requested_mushroom):
	# Pilz erhalten
	var mushroom = get_mushroom_from_player()
	if mushroom == null:
		print("Player has no Mushroom")
		return
	# Pilz Resource erhalten
	var mushroom_resource = mushroom.shroom_res
	if not mushroom_resource == requested_mushroom:
		if config.customers_only_accept_requested:
			print("Not Requestet Mushroom")
			return
		transfer_wrong_mushroom(mushroom)
		return
	transfer_correct_mushroom(mushroom)

## Holt den Pilz welchen der Spieler aktuell trägt
func get_mushroom_from_player():
	var player : Player = get_tree().get_first_node_in_group("player")
	if player.carries_object:
		for child in player.object_place.get_children():
			if child.is_in_group("pickable_mushroom"):
				return child
	return null

## Wenn der Richtige Pilz verkauft wird
func transfer_correct_mushroom(mushroom):
	# Geld je nach seltenheit auswählen
	match mushroom.shroom_res.rarity:
		GLOBALS.rarity.common:
			EventBus.update_money.emit(config.money_common_mushroom)
		GLOBALS.rarity.rare:
			EventBus.update_money.emit(config.money_rare_mushroom)
		GLOBALS.rarity.ultra_rare:
			EventBus.update_money.emit(config.money_ultra_rare_mushroom)
	handle_transfer(mushroom)

## Wenn der falsche Pilz verkauft wird
func transfer_wrong_mushroom(mushroom):
	# Geld nach seltenheit auswählen und anschließend verringern
	var reduced_money : int = 0
	match mushroom.shroom_res.rarity:
		GLOBALS.rarity.common:
			reduced_money = config.money_common_mushroom
		GLOBALS.rarity.rare:
			reduced_money = config.money_rare_mushroom
		GLOBALS.rarity.ultra_rare:
			reduced_money = config.money_ultra_rare_mushroom
	reduced_money = int(reduced_money * (config.money_percent_wrong_mushroom / 100))
	EventBus.update_money.emit(reduced_money)
	handle_transfer(mushroom)

## Transferiert den Pilz vom Spieler zum Kunden
func handle_transfer(mushroom):
	var customer : base_npc = get_tree().get_first_node_in_group("npc")
	var player : Player = get_tree().get_first_node_in_group("player")
	if customer == null or player == null:
		print("Player: ", player, " or Customer: ", customer, " null")
		return
	mushroom.get_parent().remove_child(mushroom)
	customer.object_place.add_child(mushroom)
	player.carries_object = false
	EventBus.order_complete.emit()
