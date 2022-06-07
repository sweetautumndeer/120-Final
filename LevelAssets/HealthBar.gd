extends Control

var health = 3 
var max_health = 3 

onready var bar = $ProgressBar

func _ready():
	var player = get_node("../../Player")
	#max_heal
	
