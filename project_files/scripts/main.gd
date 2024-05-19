extends Node2D

@onready var player_chicken = $PlayerChicken

@onready var main_menu = $CanvasLayer/mainMenu
@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var hud = $CanvasLayer/hud
@onready var game_over = $CanvasLayer/GameOver

var paused

func _ready():
	showMainMenu()
	paused=false
	
func gamePuase():
	
	pause_menu.show()
	
func gameResume():
	
	pause_menu.hide()
	
func showMainMenu():
	main_menu.show()
	pause_menu.hide()
	game_over.hide()
	hud.hide()
	player_chicken.hide()
		

	
func _input(event):
	if(event.is_action_pressed("pause_game")):
		paused=!paused
		if(paused):
			gamePuase()
		else:
			gameResume()
		
func _on_main_menu_startgame():
	player_chicken.show()
	hud.show()
	main_menu.hide()

func _on_main_menu_quitgame():
	get_tree().quit()

func _on_pause_menu_resumegame():
	gameResume()

