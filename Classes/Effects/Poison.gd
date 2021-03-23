class_name Poison


var activation_minute: int = 0
var deactivation_minute: int = 0


func effect(_effect: Effect, _minutes_passed):
	for _minute in _minutes_passed:
		_effect.get_parent().stats.health -= 0.076
	return null
