extends Node2D

@onready var player_chicken = $PlayerChicken

@onready var main_menu = $CanvasLayer/mainMenu
@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var hud = $CanvasLayer/hud
@onready var game_over = $CanvasLayer/GameOver
@onready var eggs = $Eggs

var paused = true;
var TOTAL_MAX_EGGS_HEALTH = 0.0;
var is_game_over = false;

func reset():
	TOTAL_MAX_EGGS_HEALTH = 0.0;
	is_game_over = false;
	

func _ready():
	showMainMenu()
	paused = true;
	is_game_over = false;
	get_tree().paused= paused;
	
	hud.get_node("HBoxContainer/ProgressBar2").max_value = player_chicken.MAX_HEALTH;
	hud.get_node("HBoxContainer/ProgressBar2").value = player_chicken.CURRENT_HEALTH;
	
	var total_current_eggs_health = 0.0;
	for egg in eggs.get_children():
		TOTAL_MAX_EGGS_HEALTH += egg.MAX_HEALTH;
		total_current_eggs_health += egg.CURRENT_HEALTH;
	hud.get_node("HBoxContainer/ProgressBar").max_value = TOTAL_MAX_EGGS_HEALTH;
	hud.get_node("HBoxContainer/ProgressBar").value = total_current_eggs_health;

func _process(delta):
	var total_current_eggs_health = 0.0;
	for egg in eggs.get_children():
		total_current_eggs_health += egg.CURRENT_HEALTH;
	hud.get_node("HBoxContainer/ProgressBar").max_value = TOTAL_MAX_EGGS_HEALTH;
	hud.get_node("HBoxContainer/ProgressBar").value = total_current_eggs_health;
	hud.get_node("HBoxContainer/ProgressBar2").value = player_chicken.CURRENT_HEALTH;
	#Game-Over logic
	if total_current_eggs_health <= 0 || player_chicken.CURRENT_HEALTH <= 0 && !is_game_over:
		paused = true;
		get_tree().paused = paused;
		showGameOverScreen();

func showGameOverScreen():
	is_game_over = true;
	hud.hide();
	game_over.show();

func gamePuase():
	paused = true;
	get_tree().paused = paused;
	pause_menu.show()
	
func gameResume():
	paused = false;
	get_tree().paused = paused
	pause_menu.hide()

func showMainMenu():
	main_menu.show();
	pause_menu.hide()
	game_over.hide()
	hud.hide()
	player_chicken.hide()
		

func _input(event):
	if(event.is_action_pressed("pause_game")):
		paused=!paused;
		if !is_game_over:
			if(paused):
				gamePuase()
			else:
				gameResume()

func _on_main_menu_startgame():
	paused = false;
	get_tree().paused = paused;
	player_chicken.show();
	game_over.hide();
	hud.show()
	main_menu.hide()

func _on_main_menu_quitgame():
	get_tree().quit()

func _on_pause_menu_resumegame():
	gameResume()

