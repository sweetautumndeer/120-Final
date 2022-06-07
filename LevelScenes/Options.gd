extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#changes music volume
func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(1, value)

#changes sfx volume
func _on_SFXSlider_value_changed(value):
	AudioServer.set_bus_volume_db(2, value)

#closes menu when pressed
func _on_CloseButton_pressed():
	visible = false
