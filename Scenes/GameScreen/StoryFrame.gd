extends GameTextureRect

signal story_selected



func _on_StoryFrame_mouse_entered():
	emit_Mouse_Entered_Effect()


func _on_StoryFrame_mouse_exited():
	if owner.selected != self:
		modulate.a = 1


func _on_StoryFrame_gui_input(event):
	emit_Pressed_Effect(event)

func _on_StoryTexture_mouse_entered():
	_on_StoryFrame_mouse_entered()


func _on_StoryTexture_mouse_exited():
	_on_StoryFrame_mouse_exited()


func _on_StoryTexture_gui_input(event):
	_on_StoryFrame_gui_input(event)


func _on_StoryFrame_texture_rect_clicked():
	emit_signal("story_selected")
