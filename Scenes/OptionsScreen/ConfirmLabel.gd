extends LabelButton







func _on_ConfirmLabel_pressed():
	get_parent().queue_free()
