extends Area2D

@onready var anim: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("key_bounce")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
