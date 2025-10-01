extends Control
# Close Inventory
## Scroll Box
@onready var scroll_container: ScrollContainer = $BackgroundImage/ScrollContainer

## Globale Config Ressource
var config: GlobalConfig = load("res://resources/global_config.tres")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if(Input.is_action_pressed("ui_cancel") or Input.is_action_pressed("joy_cancel")):
		close_inventory()
	
	# Scroll Box bewegen
	if Input.is_action_pressed("scroll_up"):
		scroll_container.scroll_vertical += int(config.scroll_speed * delta)
	if Input.is_action_pressed("scroll_down"):
		scroll_container.scroll_vertical -= int(config.scroll_speed * delta)

func close_inventory():
	if config.print_info_messages:
		print("close Inventory")
	get_tree().paused = false
	self.queue_free()
