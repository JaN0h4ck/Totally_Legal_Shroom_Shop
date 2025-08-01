extends Node2D
class_name crush_system

@onready var corpse_point: Node2D = $corpse_point

## Wenn die Leiche in die Maschine geworfen wird
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("pickable_corpse"):
		var corpse : pickable_object = area.get_parent()
		if corpse.is_picked:
			return
		crush_corpse(corpse)

## Wenn die Leiche in die Maschine übergeben wird
func on_corpse_handed_over():
	var player : Player = get_tree().get_first_node_in_group("player")
	# Schauen ob Spieler bereits ein Objekt trägt
	if not player.carries_object:
		return
	var check = check_if_player_has_corpse()
	if not check[0]:
		return
	crush_corpse(player.object_place.get_child(check[1]))
	player.carries_object = false

## Schaut ob der Spieler mommentan eine Leiche in der Hand hat
func check_if_player_has_corpse():
	var player : Player = get_tree().get_first_node_in_group("player")
	for child in player.object_place.get_children():
		if child.is_in_group("pickable_corpse"):
			return [true, child.get_index()]
	return [false, 0]

## Leiche verarbeiten
func crush_corpse(corpse : pickable_object):
	select_soil_rarity(corpse)
	corpse.crush_object()
	# Leiche an den Passenden Ort bewegen
	var tween = get_tree().create_tween()
	tween.tween_property(corpse, "global_position", corpse_point.global_position, corpse.selected_object.pickup_time).from_current()
	# Warten bevor Leiche verschwindet
	await get_tree().create_timer(corpse.selected_object.pickup_time + 0.1).timeout
	corpse.queue_free()

func select_soil_rarity(corpse : pickable_object):
	var corpse_rarity : pickable_object_resource.rarity_enum = corpse.selected_object.rarity
	match corpse_rarity:
		pickable_object_resource.rarity_enum.common:
			print("Create Common Soil")
		pickable_object_resource.rarity_enum.rare:
			print("Create Rare Soil")
		pickable_object_resource.rarity_enum.ultra_rare:
			print("Create Ultra Rare Soil")
