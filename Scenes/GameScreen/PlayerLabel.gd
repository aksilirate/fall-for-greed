extends GameLabel

var character: Object

signal character_selected(_owner)

	
func _on_FirstMemberLabel_mouse_entered():
	emit_Mouse_Entered_Effect()


func _on_FirstMemberLabel_mouse_exited():
	if owner.selected != self:
		modulate.a = 1


func _on_FirstMemberLabel_gui_input(event):
	emit_Pressed_Effect(event)
	


func _on_FirstMemberLabel_label_clicked():
#	The order is important here. 
#	The characters automatically connected here in the Area: Node
	owner.last_selected_character = character
	emit_signal("character_selected", owner)
	
