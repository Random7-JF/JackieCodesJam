extends Area2D

@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready():
	anim.play("chest_open")
