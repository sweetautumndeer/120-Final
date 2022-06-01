extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_RetryButton_pressed():
	if Global.currentCheckpoint == "Level1":
		get_tree().change_scene("res://LevelScenes/Level1.tscn")
	if Global.currentCheckpoint == "Boss":
		get_tree().change_scene("res://LevelScenes/BossLevel.tscn")


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://LevelScenes/MainMenu.tscn")
