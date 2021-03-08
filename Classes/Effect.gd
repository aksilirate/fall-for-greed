extends Node
class_name Effect



var active_minutes: int = 0
# Will apply effect after "active_minutes" reach the "activation_minute"
var activation_minute: int = 0



var active_effect # The effect type being passed

func _ready():
	activation_minute = active_effect.activation_minute
	add_to_group("Effect")



func apply_effect(_minutes_passed):
	if active_minutes >= activation_minute:
		var _result = active_effect.effect(self, _minutes_passed)
		if _result:
			return _result
		else:
			return null
	else:
		return null

