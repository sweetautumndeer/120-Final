extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print(Global.currentCheckpoint)
		if Global.currentCheckpoint == "Level1":
			Global.currentCheckpoint = "Level2"
			get_tree().change_scene("res://LevelScenes/Level2.tscn")
		elif Global.currentCheckpoint == "Level2":
			Global.currentCheckpoint = "Boss"
			get_tree().change_scene("res://LevelScenes/BossLevel.tscn")
			
