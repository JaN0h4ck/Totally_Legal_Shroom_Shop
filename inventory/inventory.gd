extends Node

var inventory_array : Array
var inventory_base_size : int = 20

## Globale Config Ressource
var config: GlobalConfig = load("res://resources/global_config.tres")
var print_info : bool = false

func _ready():
	print_info = config.print_info_messages
	EventBus.inventory_add_object_autofill.connect(add_mushroom_autofill)
	EventBus.inventory_swap_slots.connect(swap_slots)

## Pilz hinzufügen, anzahl erhöhen wenn noch nicht in Inventar, ansonsten im nächsten freien Slot
func add_mushroom(mushroom_node, specific_slot : bool, slot : int):
	if print_info:
		print("Inventory: Try to add ", mushroom_node, " to Inventory")
	if not check_if_node_is_mushroom(mushroom_node):
		push_warning("Inventory: Tried to add ", mushroom_node, " to Inventory -> Error: Not a Mushroom")
		return
	var mushroom_res : ShroomRes = get_mushroom_resource(mushroom_node)
	delete_mushroom_node(mushroom_node)
	
	# Wenn mit Autofill
	if not specific_slot:
		var inventory_check : Array = check_if_mushroom_already_in_inventory(mushroom_res)
		if inventory_check[0]:
			if print_info:
				print("Inventory: ", mushroom_res, " already in Inventory -> Increase number")
			increase_mushroom_number(inventory_check[1])
		else:
			if print_info:
				print("Inventory: ", mushroom_res, " new in Inventory -> Add to new Slot")
			var empty_check : Array = check_for_empty_slot()
			if empty_check[0]:
				add_new_mushroom_to_empty_slot(mushroom_res, empty_check[1])
			else:
				add_new_mushroom_to_end(mushroom_res)
	
	# Wenn Spezifischer Slot
	else:
		if not inventory_array[slot][0] == mushroom_res:
			push_warning("Inventory: Tried to add ", mushroom_res, " to Inventory on invalid Slot taken by ", inventory_array[slot][0])
			return
		else:
			inventory_array[slot][1] += 1
			if print_info:
				print("Inventory: Added ", mushroom_res, " to Inventory on Slot ", slot)
	
	EventBus.inventory_updated.emit()

## Slot ändern
func swap_slots(slot_1 : int, slot_2 : int):
	if print_info:
		print("Inventory: Swap Slot ", slot_1, " with Slot ", slot_2)
	# Fals Inventory Array nicht groß genug ist
	if inventory_array.size() < slot_1 or inventory_array.size() < slot_2:
		while inventory_array.size() < slot_1 or inventory_array.size() < slot_2:
			inventory_array.append([null, 0])
	var temp_slot : Array = inventory_array[slot_1]
	inventory_array[slot_1] = inventory_array[slot_2]
	inventory_array[slot_2] = temp_slot


## Pilz automatisch an bester Position im Inventar hinzufügen
func add_mushroom_autofill(mushroom_node):
	add_mushroom(mushroom_node, false, 0)

## Pilz an bestimmter Position im Inventar hinzufügen
func add_mushroom_specific_slot(mushroom_node, slot : int):
	# Fals Inventar Array noch nicht groß genug
	if inventory_array.size() < slot:
		while inventory_array.size() < slot:
			inventory_array.append([null, 0])
	add_mushroom(mushroom_node, true, slot)

## Überprüft ob Node zur Gruppe Shroom gehört
func check_if_node_is_mushroom(mushroom_node):
	if mushroom_node.is_in_group("Shroom"):
		return true
	else:
		return false

## Erhalte die Pilz Resource aus der Node
func get_mushroom_resource(mushroom_node):
	if print_info:
		print("Inventory: Get Resource ", mushroom_node.shroom_res, " from Node ", mushroom_node)
	return mushroom_node.shroom_res

## Pilz Node löschen
func delete_mushroom_node(mushroom_node):
	mushroom_node.get_parent().remove_child(mushroom_node)
	mushroom_node.queue_free()

## Schauen ob Pilz bereits im Inventar und gibt wenn ja die Postion aus
func check_if_mushroom_already_in_inventory(mushroom_res : ShroomRes):
	for i in range (inventory_array.size()):
		var slot : Array = inventory_array[i]
		if slot[0] == mushroom_res:
			return [true, i]
	return [false, 0]

## Anzahl Erhöhen da Pilz bereits im Inventar
func increase_mushroom_number(array_position : int):
	inventory_array[array_position][1] += 1
	if print_info:
		print("Inventory: Slot ", array_position, " Number now ", inventory_array[array_position][1])

## Überprüfen ob es leere Slots gibt
func check_for_empty_slot():
	for i in range (inventory_array.size()):
		var slot : Array = inventory_array[i]
		if slot[0] == null:
			return [true, i]
	return [false, 0]

## Neuen Pilz an Leerer Stelle hinzufügen
func add_new_mushroom_to_empty_slot(mushroom_res : ShroomRes, slot : int):
	inventory_array[slot] = [mushroom_res, 1]
	if print_info:
		print("Inventory: Added new Mushroom ", mushroom_res, " to Inventory at Slot ", slot)

## Neuen Pilz hinten im Inventar hinzufügen
func add_new_mushroom_to_end(mushroom_res : ShroomRes):
	inventory_array.append([mushroom_res, 1])
	if print_info:
		print("Inventory: Added new Mushroom ", mushroom_res, " to Inventory at Inventory End")
