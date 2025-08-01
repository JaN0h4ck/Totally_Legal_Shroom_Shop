extends Node

## Ausgelöst wenn mit Kunden geredet wird
signal interact_customer
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
signal npc_entered_trapdoor
## Ausgelöst wenn ein NPC die Falltür verlässt
signal npc_left_trapdoor
## Ausgelöst wenn ein NPC den Shop verlässt (entweder durch Falltür oder als Kunde)
signal npc_left_shop
## Ausgelöst wenn ein NPC durch die Falltür fällt, NPC Enum Name wird mit übergeben
signal npc_dropped(npc_name : base_npc.npc_name_enum)

## Ausgelöst wenn ein Dialog gestartet wird
signal dialog_started
## Ausgelöst wenn ein Dialog endet
signal dialog_ended

## Ausgelöst wenn Inventar geöffnet werden soll
signal open_inventory

## Ausgelöst wenn Lexikon geschlossen wird
signal lexicon_back

## Ausgelöst wenn der Spieler das Objekt welches er gerade trägt fallen lässt
signal drop_object

## Ausgelöst wenn ein Objekt aufgehoben wird, Globale Position des Objekts und Bool ob das Objekt einfach nur im Level abgelegt wurde wird mit übergeben
signal pickup_object(position : Vector2, is_random_dropped : bool)

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

func _on_npc_dropped(npc_name : base_npc.npc_name_enum):
	npc_dropped.emit(npc_name)

func _on_dialog_started():
	dialog_started.emit()

func _on_dialog_ended():
	dialog_ended.emit()

func _on_open_inventory():
	open_inventory.emit()

func _on_lexikon_closed():
	lexicon_back.emit()

func _on_drop_object():
	drop_object.emit()

func _on_pickup_object(position : Vector2, is_random_dropped : bool):
	pickup_object.emit(position, is_random_dropped)
