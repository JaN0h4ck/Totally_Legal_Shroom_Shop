extends Node2D

const FIRST_PAGE: int = 0
const LAST_PAGE: int = 2

@onready var anim = $AnimatedSprite2D
## Start Seite
@export var count: int = 0
@onready var sub_viewport_container: SubViewportContainer = $"../.."
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var page_title: Label = $Text/PageTitle
@onready var page_content: Label = $Text/PageContent
@onready var list_container: VBoxContainer = $Text/VBoxContainer

var list_element = preload("res://scenes/journal/journal_ui_item.tscn")

func _ready():
	anim.play("Page")
	display_stats()
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
	clear_list()
	match count:
		0: 
			display_stats()
		1: 
			display_upgrades()
		2: 
			display_kills()


func play_audio(old: int):
	if count == old: return
	audio_stream_player.play()

## Stats anzeigen
func display_stats():
	page_title.text =  "Stats"
	page_content.text = ""
	# List Container befüllen
	var money_info = list_element.instantiate()
	list_container.add_child(money_info)
	money_info.update_text(GameStats.money)
	money_info.texture_rect.texture = load("res://assets/ui/coin_icon.png")
	var kills_info = list_element.instantiate()
	list_container.add_child(kills_info)
	kills_info.update_text(GameStats.kills)
	kills_info.texture_rect.texture = load("res://assets/ui/coin_icon.png")
	var left_alive_info = list_element.instantiate()
	list_container.add_child(left_alive_info)
	left_alive_info.update_text(GameStats.completed_orders)
	left_alive_info.texture_rect.texture = load("res://assets/ui/coin_icon.png")

## Upgrades anzeigen
func display_upgrades():
	# Titel und Text festlegen
	page_title.text =  "Upgrade Level"
	page_content.text = ""
	# List Container befüllen
	var crusher_info = list_element.instantiate()
	list_container.add_child(crusher_info)
	crusher_info.update_text(GameStats.crusher_level)
	crusher_info.texture_rect.texture = load("res://assets/dungeon/wood_chipper.PNG")

## Kill Liste anzeigen
func display_kills():
	# Titel und Text festlegen
	page_title.text =  "Kills"
	page_content.text = "Overall Kills: " + str(GameStats.kills)
	# List Container befüllen
	for killed in GameStats.kill_list:
		var element = list_element.instantiate()
		list_container.add_child(element)
		element.update_text(killed[1])
		element.update_icon_to_killed(killed[0])

## List Container leeren
func clear_list():
	for child in list_container.get_children():
		list_container.remove_child(child)
