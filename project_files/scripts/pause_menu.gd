extends Control
@onready var main=$"../../"

func _on_resume_btn_pressed():
	main.gameResume()

func _on_main_menu_btn_pressed():
	get_tree().reload_current_scene()
