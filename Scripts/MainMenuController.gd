extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Load Level 1 on button press
func _on_PlayButton_pressed():
	print("loading stage 1...")
	get_tree().change_scene("res://Scenes/Level1.tscn")
