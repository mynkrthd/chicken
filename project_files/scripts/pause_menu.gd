extends Control

signal RESUMEGAME

func _on_resume_btn_pressed():
	RESUMEGAME.emit()


func _on_main_menu_btn_pressed():
	get_tree().reload_current_scene()
