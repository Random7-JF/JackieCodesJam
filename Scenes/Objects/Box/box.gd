extends Area2D

@onready var spawn: Marker2D = $Spawnpoint

@export var item_min: int
@export var item_max: int

var item_node: Node2D
var item_template: PackedScene = preload("res://Scenes/Objects/Item/item_template.tscn")

func _ready():
	item_node = get_tree().get_first_node_in_group("item_node")

func break_box():
	var item_count: int = randi_range(item_min, item_max)
	for i in range(item_count):
		print("Loop ", i)
		var instance = item_template.instantiate()
		item_node.add_child(instance)
		instance.global_position = spawn.global_position
		instance.pick_item(Alchemy.alchemy_type.catalyst)
	call_deferred("queue_free")
