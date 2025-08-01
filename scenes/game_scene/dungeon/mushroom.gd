extends Node2D
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var timer_step_1 : Timer = $Timer_Step_1
@onready var timer_step_2 : Timer = $Timer_Step_2
@onready var timer_regrow = $Timer_regrow
@onready var pickable_mushroom : RigidBody2D = $pickable_mushroom

@onready var alien_shroom := preload("res://scenes/Object/shrooms/Alien_shroom.tscn")
@onready var blutpilz := preload("res://scenes/Object/shrooms/Blutpilz.tscn")
@onready var champignon := preload("res://scenes/Object/shrooms/champignon.tscn")
@onready var pfifferling := preload("res://scenes/Object/shrooms/pfifferling.tscn")
@onready var ribcage := preload("res://scenes/Object/shrooms/ribcage.tscn")
@onready var toxic := preload("res://scenes/Object/shrooms/toxic.tscn")


## Timer wie lange der Pilz braucht um Schritt 2 zu erreichen
@export var timer_step_1_lenght : float = 1
## Timer wie lange der Pilz braucht um Schritt 3 zu erreichen
@export var timer_step_2_lenght : float = 1
## Sprite2D welches das Anfangsstadium anzeigt
@export var step_0_sprite : Texture2D

var empty_texture : Texture2D
var mushroom_list : Array = []
var planted_mushroom : PickableMushroom

func _ready():
	mushroom_list.append(alien_shroom)
	mushroom_list.append(blutpilz)
	mushroom_list.append(champignon)
	mushroom_list.append(pfifferling)
	mushroom_list.append(ribcage)
	mushroom_list.append(toxic)
	plant_mushroom()

func _physics_process(_delta):
	if planted_mushroom.global_position == global_position:
		timer_regrow.start()

func _on_timer_step_1_timeout():
	spawn_smal_mushroom()
	timer_step_2.start()

func _on_timer_step_2_timeout():
	spawn_grown_mushroom()

func spawn_smal_mushroom():
	#var mushroom : PickableMushroom = planted_mushroom.instantiate()
	sprite_2d.texture = planted_mushroom.item_res.smol_tex
	pass

func spawn_grown_mushroom():
	#var mushroom : PickableMushroom = planted_mushroom.instantiate()
	sprite_2d.texture = empty_texture
	planted_mushroom.z_index = -3
	planted_mushroom.z_as_relative = false
	get_tree().get_first_node_in_group("mushroom_container").add_child(planted_mushroom)
	planted_mushroom.position = position

func plant_mushroom():
	timer_step_1.autostart = false
	timer_step_1.one_shot = true
	timer_step_1.wait_time = timer_step_1_lenght
	
	timer_step_2.autostart = false
	timer_step_2.one_shot = true
	timer_step_2.wait_time = timer_step_2_lenght
	
	timer_regrow.autostart = false
	timer_regrow.one_shot = true
	timer_regrow.wait_time = timer_step_2_lenght
	
	sprite_2d.texture = step_0_sprite
	timer_step_1.start()
	
	var mushroom_to_plant = mushroom_list.pick_random()
	planted_mushroom = mushroom_to_plant.instantiate()
	


func _on_timer_regrow_timeout():
	plant_mushroom()
