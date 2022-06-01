extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _input(event):
	if (event is InputEventKey and event.pressed) or (event is InputEventMouseButton and event.pressed):
			get_tree().change_scene("res://LevelScenes/MainMenu.tscn")

