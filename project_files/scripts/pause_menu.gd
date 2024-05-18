extends Control

signal RESUMEGAME
signal GOTOMAINMENU

func _on_resume_btn_pressed():
	RESUMEGAME.emit()


func _on_main_menu_btn_pressed():
	GOTOMAINMENU.emit()
