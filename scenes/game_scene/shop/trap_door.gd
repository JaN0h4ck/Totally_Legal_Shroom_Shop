extends AnimatedSprite2D
@onready var timer : Timer = $Timer

func _ready():
	EventBus.interact_lever.connect(open)

func open():
	$".".play("open")
	timer.start()

func close():
	$".".play("close")


func _on_timer_timeout():
	close()
