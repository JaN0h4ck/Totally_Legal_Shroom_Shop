extends Node

## Ausgelöst wenn mit Kunden geredet wird
signal interact_customer(customer: base_npc, player_has_obj: bool)
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

## Pilze auf Theke anzeigen
signal display_mushroom(shroom_res : ShroomRes, slot : int)

## Inventar kurz öffnen
signal open_inventory_short()

## Ausgelöst wenn das Inventar geupdated wird
signal inventory_updated()

## Ausgelöst wenn Objekt an zufälliger Position ins Inventar gelegt werden soll, braucht als eingabe Node aus Gruppe "Shrooms"
signal inventory_add_object_autofill(mushroom_node)

## Ausgelöst wenn Objekt an bestimmter Position in Inventar geleget werden soll, braucht als eingabe Node aus Gruppe "Shrooms" und Slot Nummer
signal inventory_add_object_specific_slot(mushroom_node, slot_number : int)

## Ausgelöst wenn Zwei Inventar Slots getauscht werden
signal inventory_swap_slots(slot_1 : int, slot_2 : int)

## Ausgelöst wenn etwas aus einem bestimmten Inventar Slot entfernt werden soll
signal inventory_remove_from_slot(slot : int)

## Ausgelöst wenn ein Pilz aus dem Inventar entfernt wurde und nun in der Welt gespawnt werden muss
signal inventory_remove_mushroom(mushroom_res : ShroomRes)

## Ausgelöst wenn entweder im Dungeon oder im Shop geladen wird
signal load_shop()
signal load_dungeon()

## Ausgelöst wenn der Spieler einen Pilz verkaufen möchte
signal start_shopping()

## Ausgelöst nach dem der Spieler etwas verkaufen möchte mit der Info welches der gewünschte Pilz ist
signal sell_mushroom(requested_mushroom)

## Ausgelöst wenn der Kunde einen Pilz erhalten hat
signal order_complete()

## Ausgelöst wenn gepeichert werden soll
signal save_game()

## Ausgelöst wenn ein Spielstand geladen werden soll
signal load_game()

## Ausgelöst wenn das Pause Menü geschlossen werden soll
signal close_pause_menu()

## Ausgelöst wenn die Geld anzahl verändert wird, Positiver Wert um Geld zu erhalten, negativer zum Geld ausgeben
signal update_money(amount : int)

## Wird ausgelöst nachdem der Kunde den Shop unbeschadet verlassen hat
signal npc_left_unharmed()

## Wird ausgelöst wenn das Level des Crushers erhöht wird
signal crusher_upgrade()

## Wird ausgelöst wenn mit dem Journal im keller Interagiert wird
signal interact_journal()

## Wird ausgelöst wenn die Stats zurück gesetzt werden sollen
signal reset_stats()

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

func _on_inventory_add_object_autofill(mushroom_node):
	inventory_add_object_autofill.emit(mushroom_node)

func _on_inventory_add_object_specific_slot(mushroom_node, slot_number : int):
	inventory_add_object_specific_slot.emit(mushroom_node, slot_number)

func _on_inventory_swap_slots(slot_1 : int, slot_2 : int):
	inventory_swap_slots.emit(slot_1, slot_2)

func _on_inventory_remove_mushroom(mushroom_res : ShroomRes):
	inventory_remove_mushroom.emit(mushroom_res)

func _on_inventory_remove_from_slot(slot : int):
	inventory_remove_from_slot.emit(slot)
func _on_load_shop():
	load_shop.emit()

func _on_load_dungeon():
	load_dungeon.emit()

func _on_load_fertilizer(fert_res : FertilizerRes, loaded_position : Vector2):
	load_fertilizer.emit(fert_res, loaded_position)

func _on_load_mushroom(shroom_res : ShroomRes, saved_position : Vector2, saved_rotation : float, grow_stage : int, in_inventory : bool, inventory_position : int):
	load_mushroom.emit(shroom_res, saved_position, saved_rotation, grow_stage, in_inventory, inventory_position)

func _on_display_mushroom(shroom_res : ShroomRes, slot : int):
	display_mushroom.emit(shroom_res, slot)

func _on_open_inventory_short():
	open_inventory_short.emit()

func _on_start_shopping():
	start_shopping.emit()

func _on_sell_mushroom(requested_mushroom):
	sell_mushroom.emit(requested_mushroom)

func _on_order_complete():
	order_complete.emit()

func _on_save_game():
	save_game.emit()

func _on_load_game():
	load_game.emit()

func _on_close_pause_menu():
	close_pause_menu.emit()

func _on_update_money(amount : int):
	update_money.emit(amount)

func _on_npc_left_unhamred():
	npc_left_unharmed.emit()

func _on_crusher_upgrade():
	crusher_upgrade.emit()

func _on_interact_journal():
	interact_journal.emit()

func _on_reset_stats():
	reset_stats.emit()
