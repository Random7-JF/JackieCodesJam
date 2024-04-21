extends Area2D

@export var item: PackedScene
@export var item_node: Node2D

func break_box():
	var instance = item.instantiate()
	item_node.add_child(instance)
	instance.position = position
	call_deferred("queue_free")

