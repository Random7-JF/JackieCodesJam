extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var interact: Interact = $Interact
@onready var spawn: Marker2D = $Spawnpoint
@onready var player: Player = get_tree().get_first_node_in_group("player")

@export var item_min: int
@export var item_max: int

var item_node: Node2D
var item_template: PackedScene = preload("res://Scenes/Objects/Item/item_template.tscn")

var opened: bool = false

func _ready():
	item_node = get_tree().get_first_node_in_group("item_node")
	
func loot():
	if player.use_key() && !opened:
		anim.play("chest_open")
		$Interact.deactivate()
		opened = true
		spawn_items()
	else:
		interact.type = Interact.MessageType.Notify
		interact.message = "Return with a Key and press [E]"

func spawn_items():
	var item_count: int = randi_range(item_min, item_max)
	for i in range(item_count):
		var instance = item_template.instantiate()
		item_node.add_child(instance)
		instance.global_position = spawn.global_position
		instance.pick_item(Alchemy.alchemy_type.modifier)

func _on_interact_body_entered(body):
	if !opened:
		if body.is_in_group("player"):
			$Interact.activate()

func _on_interact_body_exited(body):
	if !opened:
		if body.is_in_group("player"):
			$Interact.deactivate()
