extends Area2D
class_name Interact

@export var action_name: String = "Interact"
@onready var label: Label = $PanelContainer/Label
@onready var panel: PanelContainer = $PanelContainer

func _ready(): 
	label.text = "[E] to " + action_name
	panel.visible = false

func activate():
	panel.visible = true
	
func deactivate():
	panel.visible = false
