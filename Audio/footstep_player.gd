class_name FootstepPlayer
extends AudioStreamPlayer2D

const FOOTSTEPS_CONCRETE: AudioStreamWAV = preload("res://Audio/Originals/SFX/FOOTSTEPS/Shrooms FX - Footsteps Concrete.wav")
const FOOTSTEPS_RUG: AudioStreamWAV = preload("res://Audio/Originals/SFX/FOOTSTEPS/Shrooms FX - Footsteps Rug.wav")
const FOOTSTEPS_SOIL: AudioStreamWAV = preload("res://Audio/Originals/SFX/FOOTSTEPS/Shrooms FX - Footsteps Soil.wav")
const FOOTSTEPS_STAIRS: AudioStreamWAV = preload("res://Audio/Originals/SFX/FOOTSTEPS/Shrooms FX - Footsteps Stairs.wav")
const FOOTSTEPS_WOOD: AudioStreamWAV = preload("res://Audio/Originals/SFX/FOOTSTEPS/Shrooms FX - Footsteps Wood.wav")

func change_sound(type: AudioFloor.FloorTypes):
	stop()
	match type:
		AudioFloor.FloorTypes.Wood:
			stream = FOOTSTEPS_WOOD
		AudioFloor.FloorTypes.Soil:
			stream = FOOTSTEPS_SOIL
		AudioFloor.FloorTypes.Rug:
			stream = FOOTSTEPS_RUG
		AudioFloor.FloorTypes.Concrete:
			stream = FOOTSTEPS_CONCRETE
