extends Resource
class_name ItemGen

@export var mod_items: Array[Alchemy]
@export var cata_items: Array[Alchemy]
@export var enhc_items: Array[Alchemy]

@export var alchemy_mode: Alchemy.alchemy_type

func PickItemCount(min: int, max: int) -> int:
	return randi_range(min,max)

func PickItems(count: int, type: Alchemy.alchemy_type) -> Array[Alchemy]:
	if type == 0:
		return mod_items
	else:
		return mod_items
