extends Area2D

func _on_body_entered(body):
	if body.has_method("get_is_attacking"):
		var check = body.get_is_attacking()
		print(check)
		if check:
			print("Player hit")
