extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

#changes scene on button press
func _on_PlayButton_pressed():
	$MenuClick.play()
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://LevelScenes/Level1.tscn")


func _on_PlayButton_mouse_entered():
	$MenuHover.play()
