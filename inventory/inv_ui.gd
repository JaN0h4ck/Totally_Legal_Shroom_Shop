extends Control

var is_open = false

func _ready():
	close()
	

func interacted():
	pass
	

func open():
	visible = true
	is_open = true


func close():
	visible = false
	is_open = false
