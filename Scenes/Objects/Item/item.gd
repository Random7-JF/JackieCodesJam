extends Area2D

@export var item_data: Alchemy
@export var spawn_time: float

var alive_time: float
var spawning: bool = true

func _ready():
	print(item_data.name)
	$Sprite2D.texture = item_data.texture
	
func _process(delta):
	if spawning:
		alive_time += delta
		if alive_time > spawn_time:
			$CollisionShape2D.disabled = false
			spawning = false
			print("Spawned")
	
func _on_area_entered(area):
	print(area)
	if area == Player:
		print("player found")
