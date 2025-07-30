extends AnimatedSprite2D
@onready var timer : Timer = $Timer

var npc_on_trapdoor : bool = false

func _ready():
	EventBus.interact_lever.connect(open)

func open():
	if not npc_on_trapdoor:
		return
	
	$".".play("open")
	timer.start()

func close():
	$".".play("close")


func _on_timer_timeout():
	close()


func _on_area_2d_body_entered(body):
	if body is base_npc:
		EventBus.npc_entered_trapdoor.emit()
		npc_on_trapdoor = true

func _on_area_2d_body_exited(body):
	if body is base_npc:
		EventBus.npc_left_trapdoor.emit()
		npc_on_trapdoor = false
