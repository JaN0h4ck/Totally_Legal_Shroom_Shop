extends Node

signal interact_customer
signal interact_register
signal interact_lexikon
signal interact_lever
signal interact_certificate
signal interact_basement
signal interact_shop

signal npc_entered_trapdoor
signal npc_left_trapdoor

signal dialog_started
signal dialog_ended

signal open_inventory

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
