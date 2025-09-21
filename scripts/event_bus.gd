extends Node

## Ausgelöst wenn mit Kunden geredet wird
signal interact_customer(customer: base_npc)
## Ausgelöst wenn mit Kasse interagiert wird
signal interact_register
## Ausgelöst wenn mit Lexikon interagiert wird
signal interact_lexikon
## Ausgelöst wenn mit Hebel interagiert wird
signal interact_lever
## Ausgelöst wenn mit Zertifikat interagiert wird
signal interact_certificate
## Ausgelöst wenn mit Tür richtung Keller interagiert wird
signal interact_basement
## Ausgelöst wenn mit Tür richtung Shop interagiert wird
signal interact_shop

## Ausgelöst wenn ein NPC auf die Falltür tritt
signal npc_entered_trapdoor(npc: base_npc)
## Ausgelöst wenn ein NPC die Falltür verlässt
signal npc_left_trapdoor
## Ausgelöst wenn ein NPC den Shop verlässt (entweder durch Falltür oder als Kunde)
signal npc_left_shop
## Ausgelöst wenn ein NPC durch die Falltür fällt, NPC Enum Name wird mit übergeben
signal npc_dropped(npc_name: GLOBALS.npc_names)

## Ausgelöst wenn ein Save Game mit einer Leiche geladen wird
signal corpse_loaded(corpse_res: CorpseRes)

## Ausgelöst wenn ein Dialog gestartet wird
signal dialog_started
## Ausgelöst wenn ein Dialog endet
signal dialog_ended

## Ausgelöst wenn Inventar geöffnet werden soll
signal open_inventory

## Ausgelöst wenn Inventar im Keller geöffnet werden soll
signal open_dungeon_inventory

## Ausgelöst wenn der Spieler das Objekt welches er gerade trägt fallen lässt
signal drop_object

## Ausgelöst wenn ein Objekt aufgehoben wird, Globale Position des Objekts und Bool ob das Objekt einfach nur im Level abgelegt wurde wird mit übergeben
signal pickup_object(position: Vector2, is_random_dropped: bool)

## Ausgelöst wenn Dünger erstellt werden soll, Position und Seltenheit wird übergeben
signal spawn_fertilizer(new_global_position: Vector2, rarity: GLOBALS.rarity)

## Ausgelöst wenn Dünger aus einem Save geladen wird
signal load_fertilizer(fert_res : FertilizerRes, loaded_position : Vector2)

## Ausgelöst wenn Pilze aus einem Save geladen werden
signal load_mushroom(shroom_res : ShroomRes, saved_position : Vector2, saved_rotation : float, grow_stage : int, in_inventory : bool, inventory_position : int)

## Ausgelöst wenn das Inventar geupdated wird
signal inventory_updated()

## Ausgelöst wenn entweder im Dungeon oder im Shop geladen wird
signal load_shop()
signal load_dungeon()

## Ausgelöst wenn der Spieler einen Pilz verkaufen möchte
signal sell_mushroom()

func _on_interact_customer():
	interact_customer.emit()

func _on_interact_register():
	interact_register.emit()

func _on_interact_lexikon():
	interact_lexikon.emit()

func _on_interact_lever():
	interact_lever.emit()

func _on_interact_certificate():
	interact_certificate.emit()

func _on_interact_basement():
	interact_basement.emit()

func _on_interact_shop():
	interact_shop.emit()

func _on_npc_entered_trapdoor():
	npc_entered_trapdoor.emit()

func _on_npc_left_trapdoor():
	npc_left_trapdoor.emit()

func _on_npc_left_shop():
	npc_left_shop.emit()

func _on_npc_dropped(npc_name: GLOBALS.npc_names):
	npc_dropped.emit(npc_name)

func _on_corpse_loaded(corpse_res: CorpseRes):
	corpse_loaded.emit(corpse_res)

func _on_dialog_started():
	dialog_started.emit()

func _on_dialog_ended():
	dialog_ended.emit()

func _on_open_inventory():
	open_inventory.emit()

func _on_open_dungeon_inventory():
	open_dungeon_inventory.emit()

func _on_drop_object():
	drop_object.emit()

func _on_pickup_object(position: Vector2, is_random_dropped: bool):
	pickup_object.emit(position, is_random_dropped)

func _on_spawn_fertilizer(new_global_position: Vector2, rarity: GLOBALS.rarity):
	spawn_fertilizer.emit(new_global_position, rarity)

func _on_inventory_updated():
	inventory_updated.emit()

func _on_load_shop():
	load_shop.emit()

func _on_load_dungeon():
	load_dungeon.emit()

func _on_load_fertilizer(fert_res : FertilizerRes, loaded_position : Vector2):
	load_fertilizer.emit(fert_res, loaded_position)

func _on_load_mushroom(shroom_res : ShroomRes, saved_position : Vector2, saved_rotation : float, grow_stage : int, in_inventory : bool, inventory_position : int):
	load_mushroom.emit(shroom_res, saved_position, saved_rotation, grow_stage, in_inventory, inventory_position)

func _on_sell_mushroom():
	sell_mushroom.emit()
