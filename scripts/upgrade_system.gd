extends Node

## Globale Config Ressource
var config: GlobalConfig = load("res://resources/global_config.tres")
## Upgrade Kosten
var upgrade_costs : int = 0
## Aktuelles Level des zu Upgradenden
var current_level : int = 1
## Ob das Upgrade erfolgreich war
var upgrade_success : bool = false

func _ready() -> void:
	EventBus.crusher_upgrade.connect(upgrade_crusher)

## Crusher Upgraden
func upgrade_crusher():
	# Schauen ob Upgrade Möglich und wenn ja Spieler Geld abziehen
	upgrade_success = upgrade_object(
						GameStats.crusher_level, 
						config.upgrade_level_limit_crusher, 
						config.max_upgrade_level_crusher, 
						config.first_upgrade_costs_crusher, 
						config.upgrade_price_increase_crusher
						)
	# Wenn möglich, Crusher Level erhöhen
	if upgrade_success:
		GameStats.crusher_level += 1

## Zieht dem Spieler das Geld für das Upgrade ab, falls das Upgrade möglich ist
func upgrade_object(object_current_level : int, object_has_level_limit : bool, object_max_level : int, object_first_upgrade_cost : int, object_upgrade_price_increase : float):
	# Aktuelles Level holen
	current_level = object_current_level
	
	# Schauen ob Crusher Max Level bereits erreicht hat
	if object_has_level_limit and current_level >= object_max_level:
		print("Max Level Reached")
		return false
	
	# Ausrechnen wie viel Upgrade kostet und ob Spieler genügend Geld hat
	calculate_upgrade_costs(object_first_upgrade_cost, object_upgrade_price_increase)
	if not check_if_player_has_enough_money():
		print("Player has not enough Money")
		return false
	
	# Spieler geld abziehen
	reduce_player_money()
	return true

## Erzeugt Upgrade Costen als Int
func calculate_upgrade_costs(first_upgrade_costs, upgrade_price_increase):
	# Beispiel Level 2 zu Level 3: Kosten = 10 + (10 * (30% * 2))
	upgrade_costs = int(first_upgrade_costs + (first_upgrade_costs * ((upgrade_price_increase / 100) * current_level)))

## Schaut ob Spieler genügend Geld hat, gibt bool zurück
func check_if_player_has_enough_money():
	if GameStats.money >= upgrade_costs:
		return true
	else:
		return false

## Spieler Geld abziehen
func reduce_player_money():
	GameStats.update_money(-upgrade_costs)
