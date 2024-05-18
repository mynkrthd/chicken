extends Control

signal STARTGAME
signal QUITGAME
var timer:=0

func _on_start_btn_pressed():
	STARTGAME.emit()

func _on_quit_btn_pressed():
	QUITGAME.emit()
