extends Control


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Level1.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
