extends Node2D


export var speed = 500
var hitEnemy = false

func _ready():
	set_as_toplevel(true)
	
#moves bullet forward at rate of speed at the rotation of the origin of the instance
func _process(delta):
	if not hitEnemy:
		position += (Vector2.RIGHT * speed).rotated(rotation) * delta
	
func _physics_process(_delta):
	yield(get_tree().create_timer(0.01), "timeout")
	set_physics_process(false)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Hitbox_area_entered(area):
	$PlayerBulletHitbox.queue_free()
	$Sprite.visible = false
	hitEnemy = true
	print("enemyhit")
	
	print(area.name)
	if area.name == "BossHitbox" or area.name == "EnemyHitbox":
		$EnemyHit.play()
	
	yield(get_tree().create_timer(0.55), "timeout")
	queue_free()
