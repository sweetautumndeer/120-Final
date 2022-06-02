extends Position2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bullet = preload("res://Enemies/EnemyBullet.tscn")
onready var player = get_node("../../Player");
var can_fire = true;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#aim at player
	if player != null:
		look_at(player.get_position())
		if can_fire && player.position.x - $"..".position.x > -1 * get_viewport().size.x / 6 && $"..".position.x - player.position.x < get_viewport().size.x / 6:
			var bullet_instance = bullet.instance()
			bullet_instance.rotation = rotation
			bullet_instance.speed = -1000
			
			#flips bullet if gun is flipped
			if get_node("../AnimatedSprite").flip_v == true:
				bullet_instance.get_node("Sprite").set_flip_v(false)
			
			#creates instance at gun position
			bullet_instance.global_position = $".".global_position
			get_parent().add_child(bullet_instance)
			
			#timer until gun can be fire again
			can_fire = false
			yield(get_tree().create_timer(2.0), "timeout")
			can_fire = true;
