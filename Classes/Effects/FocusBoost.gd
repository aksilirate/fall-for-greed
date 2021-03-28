class_name FocusBoost


var activation_minute: int = 0
var deactivation_minute: int = 0


func effect(_effect: Effect, _minutes_passed):
	pass



func activation_effect(_effect: Effect):
	_effect.get_parent().traits["focus"] += 5.2
	
func deactivation_effect(_effect: Effect):
	_effect.get_parent().traits["focus"] -= 5.2
