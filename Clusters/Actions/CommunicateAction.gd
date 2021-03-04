class_name CommunicateAction



const TEXTURE = "res://Textures/Actions/Communicate.png"



func init_action(action_methods: ActionTextureRect) -> void:
	var _character = action_methods.area.current_event
	action_methods.upcoming_stories.push_back(_character.NAME + " have decided to join you")
	var _main_story = "you have talked with " + _character.NAME
	action_methods.emit_story_telling(_main_story)
	action_methods.summon_character(_character.CHARACTER_OBJECT)
	action_methods.reset_location()
