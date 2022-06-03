extends Button


onready var menuHover = $MenuHover
onready var menuClick = $MenuClick


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

#changes scene on button press
func _on_PlayButton_pressed():
	visible = false
	$"../OptionsButton".visible = false
	menuClick.play()
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://LevelScenes/Level1.tscn")


func _on_PlayButton_mouse_entered():
	menuHover.play()


func _on_OptionsButton_pressed():
	menuClick.play()
	$"../OptionsMenu".visible = true


func _on_OptionsButton_mouse_entered():
	menuHover.play()
