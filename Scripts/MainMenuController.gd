extends Button


onready var menuHover = $MenuHover
onready var menuClick = $MenuClick
onready var transition = get_node("../TransitionScreen/AnimationPlayer")
onready var screen = get_node("../TransitionScreen")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

#changes scene on button press
func _on_PlayButton_pressed():
	#sets play button and options button invisible
	visible = false
	$"../OptionsButton".visible = false
	
	#plays click sound
	menuClick.play()
	
	#screen transition
	screen.visible = true
	transition.play("fade")
	yield(get_tree().create_timer(2), "timeout")
	
	#changes scene
	get_tree().change_scene("res://LevelScenes/Level1.tscn")

#plays hover cound for play button
func _on_PlayButton_mouse_entered():
	menuHover.play()

#displays options menu
func _on_OptionsButton_pressed():
	menuClick.play()
	$"../OptionsMenu".visible = true

#plays hover sound for options button
func _on_OptionsButton_mouse_entered():
	menuHover.play()
