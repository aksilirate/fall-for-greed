class_name MosquitoBite


var activation_minute: int = 0
var deactivation_minute: int = 0


func effect(_effect: Effect, _minutes_passed):
	for _minute in _minutes_passed:
		if rand_range(0,1) < 0.003:
			var _character = _effect.get_parent()
			_character.upcoming_stories.append(_character.character_name + " is itching")
			_effect.get_parent().stats["mood"] -= 0.01
	return null

