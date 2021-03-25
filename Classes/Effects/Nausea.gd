class_name Nausea


var activation_minute: int = 0
var deactivation_minute: int = 0


func effect(_effect: Effect, _minutes_passed):
	for _minute in _minutes_passed:
		randomize()
		if round(rand_range(0,10)) == OK:
			_effect.get_parent().stats["hunger"] -= 0.3
			return " have vomited"
	return null




func activation_effect(_effect: Effect):
	var _character = _effect.get_parent()
	if not _character.active_effects.has("nauseus"):
		_character.upcoming_stories.append(_character.character_name + " is feeling nauseus")
		_character.active_effects.append("nauseus")
	
func deactivation_effect(_effect: Effect):
	if _effect.get_parent().active_effects.has("nauseus"):
		_effect.get_parent().active_effects.erase("nauseus")
