extends ForgedLabel



func _on_ThirdMemberLabel_mouse_entered():
	emit_Mouse_Entered_Effect()


func _on_ThirdMemberLabel_mouse_exited():
	modulate.a = 1
