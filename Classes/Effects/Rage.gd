class_name Rage


var activation_minute: int = 0
var deactivation_minute: int = 0


func effect(_effect: Effect, _minutes_passed):
	pass



func activation_effect(_effect: Effect):
	_effect.get_parent().traits["strength"] += 0.6
	_effect.get_parent().stats["mood"] -= 0.3
	
	
func deactivation_effect(_effect: Effect):
	_effect.get_parent().traits["strength"] -= 0.6
