extends Area2D
class_name Interact

@export var type : MessageType = MessageType.Interact
@export var action_name: String = "Interact"
@export var message: String = "Message"
@onready var label: Label = $PanelContainer/Label
@onready var panel: PanelContainer = $PanelContainer 

enum MessageType {
	Interact, Notify
}

func _ready():
	if type == MessageType.Interact:
		label.text = "[E] to " + action_name
	elif type == MessageType.Notify:
		label.text = message
	panel.visible = false

func activate():
	panel.visible = true
	
func deactivate():
	panel.visible = false
