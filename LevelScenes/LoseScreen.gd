extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TransitionScreen/AnimationPlayer.play_backwards("fade")
	yield($TransitionScreen/AnimationPlayer, "animation_finished")
	$TransitionScreen.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#respawn player at start of level based on global checkpoint
func _on_RetryButton_pressed():
	if Global.currentCheckpoint == "Level1":
		get_tree().change_scene("res://LevelScenes/Level1.tscn")
	if Global.currentCheckpoint == "Level2":
		get_tree().change_scene("res://LevelScenes/Level2.tscn")
	if Global.currentCheckpoint == "Boss":
		get_tree().change_scene("res://LevelScenes/BossLevel.tscn")

#changes to main menu
func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://LevelScenes/MainMenu.tscn")
