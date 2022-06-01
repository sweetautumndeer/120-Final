extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_ENTER:
			get_tree().change_scene("res://LevelScenes/MainMenu.tscn")

