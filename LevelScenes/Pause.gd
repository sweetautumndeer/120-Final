extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused:
			if $OptionsMenu.visible:
				$OptionsMenu.visible = false
			else:
				visible = false
				get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true


func _on_OptionsButton_pressed():
	$OptionsMenu.visible = true


func _on_MainMenuButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://LevelScenes/MainMenu.tscn")


func _on_ResumeButton_pressed():
	visible = false
	get_tree().paused = false
