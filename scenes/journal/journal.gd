extends Node2D

const FIRST_PAGE: int = 0
const LAST_PAGE: int = 3

@onready var anim = $AnimatedSprite2D
@export var count: int = 0
@onready var sub_viewport_container: SubViewportContainer = $"../.."
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var page_title: Label = $Text/PageTitle
@onready var page_content: Label = $Text/PageContent
@onready var kill_list_container: VBoxContainer = $Text/KillListContainer

var kill_list_element = preload("res://scenes/journal/journal_kill_list.tscn")

func _ready():
	anim.play("Page")
	display_money_stats()
	get_tree().paused = true

func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("ui_left")):
		var old = count
		count -= 1
		count = clampi(count, FIRST_PAGE, LAST_PAGE)
		page()
		play_audio(old)
		return
	if(Input.is_action_just_pressed("ui_right")):
		var old = count
		count += 1
		count = clampi(count, FIRST_PAGE, LAST_PAGE)
		page()
		play_audio(old)
		return
	if(Input.is_action_pressed("ui_cancel") or Input.is_action_pressed("joy_cancel")):
		get_tree().paused = false
		sub_viewport_container.queue_free()

func page():
	match count:
		0: 
			display_money_stats()
		1: 
			display_upgrade_stats()
		2: 
			display_kill_stats()
		3:
			display_left_alive_stats()


func play_audio(old: int):
	if count == old: return
	audio_stream_player.play()

func display_money_stats():
	page_title.text =  "Money"
	page_content.text = "Current Money: " + str(GameStats.money)

func display_upgrade_stats():
	page_title.text =  "Upgrades"
	page_content.text = "Crusher Level: " + str(GameStats.crusher_level)

func display_left_alive_stats():
	page_title.text =  "Left Alive"
	page_content.text = "Customers Left Aliv: " + str(GameStats.completed_orders)

func display_kill_stats():
	page_title.text =  "Kills"
	page_content.text = "Overall Kills: " + str(GameStats.kills)
	for killed in GameStats.kill_list:
		var element = kill_list_element.instantiate()
		kill_list_container.add_child(element)
		element.update_text(killed[1])
		element.update_icon(killed[0])
