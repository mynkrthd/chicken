extends Node2D

@onready var main_menu = $mainMenu
@onready var pause_menu = $PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	pause_menu.hide()
	main_menu.show()

func resumeGame():
	pause_menu.hide()
	get_tree().paused = false

func pauseGame():
	pause_menu.show()
	get_tree().paused = true

func _input(event):
	pauseGame()

func _on_main_menu_startgame():
	main_menu.hide()

func _on_main_menu_quitgame():
	get_tree().quit()


func _on_pause_menu_resumegame():
	resumeGame()
