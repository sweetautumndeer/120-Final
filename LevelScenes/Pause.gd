extends Node2D

onready var menuHover = $MenuHover
onready var menuClick = $MenuClick

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#brings up option menu and pauses or leaves and resumes
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

#displays options menu
func _on_OptionsButton_pressed():
	menuClick.play()
	$OptionsMenu.visible = true

#pauses screen
func _on_MainMenuButton_pressed():
	menuClick.play()
	get_tree().paused = false
	get_tree().change_scene("res://LevelScenes/MainMenu.tscn")

#unpauses screen
func _on_ResumeButton_pressed():
	menuClick.play()
	visible = false
	get_tree().paused = false


func _on_ResumeButton_mouse_entered():
	menuHover.play()


func _on_OptionsButton_mouse_entered():
	menuHover.play()


func _on_MainMenuButton_mouse_entered():
	menuHover.play()
