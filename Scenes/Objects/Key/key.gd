extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer

var lootable: bool = true

func _ready():
	anim.play("key_bounce")

func loot():
	print("loot")
	if lootable:
		var player: Player = get_tree().get_first_node_in_group("player")
		player.keys += 1
		lootable = false
		call_deferred("queue_free")

func _on_interact_body_entered(body):
	if body.is_in_group("player"):
		$Interact.activate()

func _on_interact_body_exited(body):
	if body.is_in_group("player"):
		$Interact.deactivate()
