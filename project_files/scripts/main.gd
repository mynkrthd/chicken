extends Node2D

@onready var player_chicken = $PlayerChicken

@onready var main_menu = $CanvasLayer/mainMenu
@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var hud = $CanvasLayer/hud
@onready var game_over = $CanvasLayer/GameOver


func _ready():
	main_menu.show()
	pause_menu.hide()
	game_over.hide()
	hud.hide()
	player_chicken.hide()
	

	


func _on_main_menu_startgame():
	player_chicken.show()
	hud.show()
	main_menu.hide()


func _on_main_menu_quitgame():
	get_tree().quit()
