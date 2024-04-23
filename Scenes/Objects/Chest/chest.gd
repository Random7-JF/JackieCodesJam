extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var interact: Interact = $Interact
@onready var player: Player = get_tree().get_first_node_in_group("player")

var opened: bool = false

func loot():
	if player.use_key() && !opened:
		anim.play("chest_open")
		$Interact.deactivate()
		opened = true
	else:
		interact.type = Interact.MessageType.Notify
		interact.message = "Return with a Key and press [E]"

func _on_interact_body_entered(body):
	if !opened:
		print(body)
		if body.is_in_group("player"):
			$Interact.activate()

func _on_interact_body_exited(body):
	if !opened:
		if body.is_in_group("player"):
			$Interact.deactivate()
