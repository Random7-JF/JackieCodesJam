extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready():
	pass


func _on_interact_body_entered(body):
	print(body)
	if body.is_in_group("player"):
		$Interact.activate()
		print("Player found")


func _on_interact_body_exited(body):
	if body.is_in_group("player"):
		$Interact.deactivate()
		print("Player Left")
