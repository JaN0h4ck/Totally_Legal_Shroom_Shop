extends Node
class_name Inventory

var inventory_array : Array

func add_mushroom_to_inventory(new_item : PickableMushroom):
	for i in range(inventory_array.size()):
		var current_mushroom : Array = inventory_array[i]
		if current_mushroom[0] == new_item.name:
			current_mushroom[1] += 1
			inventory_array[i] = current_mushroom
			return
	var new_mushroom : Array = [new_item.name, 1]
	inventory_array.append(new_mushroom)
