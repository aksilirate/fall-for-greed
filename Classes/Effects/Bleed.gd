class_name Bleed


var activation_minute: int = 0
var deactivation_minute: int = 0


func effect(_effect: Effect, _minutes_passed):
	for _minute in _minutes_passed:
		_effect.get_parent().stats.health -= deactivation_minute * 0.01
	return null




func activation_effect(_effect: Effect):
	var _character = _effect.get_parent()
	if deactivation_minute > 30:
		_character.upcoming_stories.append(_character.character_name + " is bleeding")
	_character.active_effects.append("bleeding")
	
func deactivation_effect(_effect: Effect):
	var _character = _effect.get_parent()
	if deactivation_minute > 30:
		_character.upcoming_stories.append(_character.character_name + " stopped bleeding")
	_effect.get_parent().active_effects.erase("bleeding")
