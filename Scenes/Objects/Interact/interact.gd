extends Area2D
class_name Interact

@export var type : MessageType = MessageType.Interact
@export var action_name: String = "Interact"
@export var message: String = "Message"

@onready var message_box: MessageBox = get_tree().get_first_node_in_group("messagebox")

enum MessageType {
	Interact, Notify
}

func activate():
	if type == MessageType.Interact:
		message_box.update("[E] to " + action_name)
	elif type == MessageType.Notify:
		message_box.update(message)

func deactivate():
	message_box.hide_box()
