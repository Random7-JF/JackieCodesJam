extends RigidBody2D
class_name Item

@export var item_mod_data: Array[Alchemy]
@export var item_cata_data: Array[Alchemy]
@export var item_ench_data: Array[Alchemy]

@export var spawn_time: float = 0.5

var alive_time: float
var spawning: bool = true
var item_id: int

func pick_item(type: Alchemy.alchemy_type):
	print("Picking Item")
	match type:
		Alchemy.alchemy_type.modifier:
			item_id = randi_range(0, item_mod_data.size()-1)
			$Sprite.texture = item_mod_data[item_id].texture
		Alchemy.alchemy_type.catalyst:
			item_id = randi_range(0, item_cata_data.size()-1)
			$Sprite.texture = item_cata_data[item_id].texture
		Alchemy.alchemy_type.catalyst:
			item_id = randi_range(0, item_cata_data.size()-1)
			$Sprite.texture = item_ench_data[item_id].texture

func _process(delta):
	if spawning:
		alive_time += delta
		if alive_time > spawn_time:
			$CollisionShape2D.disabled = false
			spawning = false

func _on_area_entered(area):
	print(area)
	if area == Player:
		print("player found")

func _on_interact_body_entered(body):
	if body.is_in_group("player"):
		$Interact.activate()

func _on_interact_body_exited(body):
	if body.is_in_group("player"):
		$Interact.deactivate()
