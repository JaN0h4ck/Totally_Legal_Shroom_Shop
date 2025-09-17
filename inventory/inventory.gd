extends Node

var inventory_array : Array
var inventory_base_size : int = 20

func _ready():
	# Inventar mit leeren Plätzen füllen
	var empty_slot = [null, 0]
	for i in range(inventory_base_size):
		inventory_array.append(empty_slot)

## Einen Pilz zum Inventar hinzufügen, nicht an einen festen Platz
func add_mushroom_to_inventory_random_position(new_item):
	# Schauen ob Pilz Art bereits im Inventar wenn ja Anzahl erhöhen
	for i in range(inventory_array.size()):
		var current_mushroom : Array = inventory_array[i]
		if current_mushroom[0] == new_item:
			current_mushroom[1] += 1
			inventory_array[i] = current_mushroom
			EventBus.inventory_updated.emit()
			return
	# Pilz neu hinzufügen
	var new_mushroom : Array = [new_item, 1]
	# Wenn Pilz noch nicht im Inventar ist an erste frei stelle hinzufügen
	for i in range(inventory_array.size()):
		var current_mushroom : Array = inventory_array[i]
		if current_mushroom[0] == null:
			inventory_array[i] = new_mushroom
			EventBus.inventory_updated.emit()
			return
	# Wenn keine frei Stelle hinten ans Array hinzufügen
	inventory_array.append(new_mushroom)
	EventBus.inventory_updated.emit()

## Einen Pilz ins Inventar an einen festen Platz hinzufügen, returned ob erfolgreich
func add_mushroom_to_inventory_fix_position(new_item, position : int):
	if position > inventory_array.size():
		inventory_array[position] = [new_item, 1]
		EventBus.inventory_updated.emit()
		return true
	var item : Array = inventory_array[position]
	if item[0] == null:
		inventory_array[position] = [new_item, 1]
		EventBus.inventory_updated.emit()
		return true
	print("Place already in use by diffrent Mushroom")
	return false

## Bestimmten Pilz aus Inventar entfernen, returnd ob erfolgreich
func remove_mushroom_from_inventory_by_name(removed_item):
	for i in range(inventory_array.size()):
		var current_mushroom : Array = inventory_array[i]
		if current_mushroom[0] == removed_item:
			if current_mushroom[1] <= 1:
				var empty_item : Array = [null, 0]
				inventory_array[i] = empty_item
				EventBus.inventory_updated.emit()
				return true
			else:
				current_mushroom[1] -= 1
				inventory_array[i] = current_mushroom
				EventBus.inventory_updated.emit()
				return true
	print("Mushrom could not be found")
	return false

## Pilz an bestimmter Position entfernt, returned ob erfolgreich
func remove_mushroom_from_inventory_by_position(removed_item_position : int):
	# Schauen ob Position gültig ist
	if removed_item_position > inventory_array.size() - 1:
		print("Requestet Position ", removed_item_position, " to high")
		return false
	var current_item = inventory_array[removed_item_position]
	if current_item[0] == null:
		print("Requestet Position ", removed_item_position, " empty")
		return false
	# Wenn nur ein Pilz dort liegt
	if current_item[1] <= 1:
		var empty_item : Array = [null, 0]
		inventory_array[removed_item_position] = empty_item
		EventBus.inventory_updated.emit()
		return true
	# Wenn mehr als 1 Pilz dort liegt
	else:
		current_item[1] -= 1
		inventory_array[removed_item_position] = current_item
		EventBus.inventory_updated.emit()
		return true

## Art des Pilzes an bestimmter Position erfahren
func get_mushroom_type_at_position(position : int):
	# Schauen ob an Postion ein Item liegt
	if position > inventory_array.size():
		print("Requestet Position ", position, " to high")
		return [null, 0]
	var item : Array = inventory_array[position]
	if item[0] == null:
		#print("Requestet Position ", position, " empty")
		return [null, 0]
	# Item zurückgeben
	return inventory_array[position]
