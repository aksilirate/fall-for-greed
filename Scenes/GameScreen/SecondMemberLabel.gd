extends ForgedLabel



func _on_SecondMemberLabel_mouse_entered():
	emit_Mouse_Entered_Effect()


func _on_SecondMemberLabel_mouse_exited():
	modulate.a = 1
