extends PanelContainer
class_name MessageBox

@onready var label: Label = $MarginContainer/Label

func _ready():
	visible = false

func update(message: String):
	label.text = message
	visible = true

func hide_box():
	visible = false
