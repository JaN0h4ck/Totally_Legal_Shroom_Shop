extends Node2D



func teleport_basement():
	$teleport_point_basement/BasementDoorAudio.play()

func teleport_shop():
	$teleport_point_shopt/ShopDoorAudio.play()
	var player : Player = get_tree().get_first_node_in_group("player")
