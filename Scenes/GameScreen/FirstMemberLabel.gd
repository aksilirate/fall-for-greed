extends GameLabel

var character: Object

signal character_selected(_area)



func _on_SecondMemberLabel_mouse_entered():
	emit_Mouse_Entered_Effect()
	
func _on_SecondMemberLabel_mouse_exited():
	if owner.selected != self:
		modulate.a = 1
	
	
func _on_SecondMemberLabel_gui_input(event):
	emit_Pressed_Effect(event)



func _on_SecondMemberLabel_label_clicked():
	emit_signal("character_selected", owner)
	owner.last_selected_character = character
