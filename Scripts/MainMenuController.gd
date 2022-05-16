extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

#changes scene on button press
func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Level1.tscn")
