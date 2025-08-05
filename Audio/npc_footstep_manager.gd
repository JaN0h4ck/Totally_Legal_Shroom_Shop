extends FootstepManager

@onready var npc: base_npc = $".."

func _physics_process(_delta: float) -> void:
	if footstep_player.playing:
		if not npc.is_moving():
			footstep_player.stop()
			return
	else:
		footstep_player.play()
