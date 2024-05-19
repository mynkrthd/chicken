extends Control

func _on_quit_btn_pressed():
	get_tree().quit()

func _on_main_menu_btn_pressed():
	get_tree().reload_current_scene();
