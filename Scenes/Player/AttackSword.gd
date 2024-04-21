extends Area2D

var player: Player
var last_direction: Vector2

func _ready():
	player = get_parent()
	
func _process(delta):
	if not player.velocity == Vector2.ZERO:
		last_direction = player.velocity
	if last_direction.x > 0:
		$CollisionShape2D.position = Vector2(15,1.5)
	else:
		$CollisionShape2D.position = Vector2(-15,-1.5)
