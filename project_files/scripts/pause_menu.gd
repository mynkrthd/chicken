extends Control

signal RESUMEGAME

func _on_resume_btn_pressed():
	RESUMEGAME.emit()
