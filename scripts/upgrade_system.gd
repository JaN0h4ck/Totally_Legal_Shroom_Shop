extends Node

## Globale Config Ressource
var config: GlobalConfig = load("res://resources/global_config.tres")
## Upgrade Kosten
var upgrade_costs : int
## Aktuelles Level des zu Upgradenden
var current_level : int 

func _ready() -> void:
	EventBus.crusher_upgrade.connect(upgrade_crusher)

func upgrade_crusher():
	# Aktuelles Level holen
	current_level = GameStats.crusher_level
	
	# Schauen ob Crusher Max Level hat
	if config.upgrade_level_limit_crusher and current_level >= config.max_upgrade_level_crusher:
		return
	
	upgrade_crusher_costs()
	if not check_if_player_has_enough_money():
		return

## Erzeugt Upgrade Costen für den Crusher als Int
func upgrade_crusher_costs():
	# Beispiel Level 2 zu Level 3: Kosten = 10 + (10 * (30% * 2))
	upgrade_costs = int(config.first_upgrade_costs_crusher + (config.first_upgrade_costs_crusher * ((config.upgrade_price_increase_crusher / 100) * current_level)))

## Schaut ob Spieler genügend Geld hat, gibt bool zurück
func check_if_player_has_enough_money():
	if GameStats.money >= upgrade_costs:
		return true
	else:
		return false
