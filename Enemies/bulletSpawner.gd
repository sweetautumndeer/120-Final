extends Position2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bullet = preload("res://Enemies/EnemyBullet.tscn")
var can_fire = true;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.rotation = rotation
		
		#creates instance at gun position
		bullet_instance.global_position = $".".global_position
		get_parent().add_child(bullet_instance)
		
		#timer until gun can be fire again
		can_fire = false
		yield(get_tree().create_timer(1.0), "timeout")
		can_fire = true;
