extends PanelContainer

@onready var label: Label = $MarginContainer/HBoxContainer/Label
@onready var player: Player = get_tree().get_first_node_in_group("player")

func _ready():
	player.connect("update_key", update_key_ui)

func update_key_ui(keys: int):
	label.text = str(keys)
