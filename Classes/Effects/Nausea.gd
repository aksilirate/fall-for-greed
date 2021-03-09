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






func activation_effect():
	pass
	
func deactivation_effect():
	pass
