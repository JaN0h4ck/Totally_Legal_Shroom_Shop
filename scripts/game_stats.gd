extends Node

var kills: int = 0
var kill_list : Array = []
var completed_orders: int = 0
var money: int = 0
var crusher_level : int = 1

func _ready() -> void:
	EventBus.npc_dropped.connect(npc_killed)
	EventBus.npc_left_unharmed.connect(complete_customer_order)
	EventBus.update_money.connect(update_money)
	EventBus.crusher_upgrade.connect(rise_crusher_level)

## Kill anzahl erhöhen
func npc_killed(npc_name: GLOBALS.npc_names):
	# Kills erhöhen
	kills += 1
	
	# NPC zur Liste hinzufügen
	add_npc_to_kill_list(npc_name)

## Kill Liste aktuallisieren
func add_npc_to_kill_list(npc_name: GLOBALS.npc_names):
	# Schauen ob npc bereits getötet wurde, wenn ja kill anzahl +1
	for kill_info : Array in kill_list:
		if kill_info[0] == npc_name:
			kill_info[1] += 1
			return
	
	# Wenn NPC bisher noch nicht getötet wurde, zur list hinzufügen
	var new_kill_info : Array
	new_kill_info.append(npc_name)
	new_kill_info.append(1)
	kill_list.append(new_kill_info)
	return

## Anzahl erfüllter aufträge erhöhen
func complete_customer_order():
	completed_orders += 1

## Geld Anzahl im besitz ändern
func update_money(amount : int):
	money += amount

## Crusher Level erhöhen
func rise_crusher_level():
	crusher_level += 1
