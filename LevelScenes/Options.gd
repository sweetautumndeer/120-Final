extends Node2D

onready var menuHover = $MenuHover
onready var menuClick = $MenuClick

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#changes music volume
func _on_MusicSlider_value_changed(value):
	var result = 20 * log(value)
	AudioServer.set_bus_volume_db(1, result)

#changes sfx volume
func _on_SFXSlider_value_changed(value):
	var result = 20 * log(value)
	AudioServer.set_bus_volume_db(2, result)

#closes menu when pressed
func _on_CloseButton_pressed():
	menuClick.play()
	visible = false

func _on_CloseButton_mouse_entered():
	menuHover.play()

func _on_SFXSlider_focus_exited():
	menuHover.play()
