class_name MakeCampfireAction



const TEXTURE = "res://Textures/Actions/Make Campfire.png"



func init_action(action_methods: ActionTextureRect) -> void:
	action_methods.destroy_item_after_story()
	
	
	if action_methods.area.current_event.get_class() != "CampfireEvent":
		action_methods.emit_story_telling("you have started a campfire")
		action_methods.change_event_to(CampfireEvent)
	else:
		action_methods.emit_story_telling("you threw your sticks into the campfire")
	
