extends Resource
class_name Alchemy

@export var name: String
@export var texture: Texture2D
@export var type: alchemy_type

enum alchemy_type {
	modifier, catalyst, enhancer
}
