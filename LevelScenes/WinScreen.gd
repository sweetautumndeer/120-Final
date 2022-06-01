extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var maxTime = 2.5
var t = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	t = 0

func _process(delta):
	t += delta
	if t > maxTime:
		$Continue.visible = true

func _input(event):
	if t > maxTime and ((event is InputEventKey and event.pressed) or (event is InputEventMouseButton and event.pressed)):
		get_tree().change_scene("res://LevelScenes/Credits.tscn")

#func _process(delta):
#	pass