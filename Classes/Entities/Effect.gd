extends Node
class_name Effect

 

var active_minutes: int = 0
# Will apply effect after "active_minutes" reach the "activation_minute"
var activation_minute: int = 0
var deactivation_minute: int = 0


var activation_effect_activated = false




var active_effect # The effect type being passed
func _ready():
	activation_minute = active_effect.activation_minute
	deactivation_minute = active_effect.deactivation_minute
	add_to_group("Effect")



func apply_effect(_minutes_passed):
	
	if deactivation_minute != 0 and active_minutes >= deactivation_minute:
		if active_effect.has_method("deactivation_effect"):
			active_effect.deactivation_effect(self)
		queue_free()
	
	elif active_minutes >= activation_minute:
		var _result = active_effect.effect(self, _minutes_passed)
		if not activation_effect_activated:
			if active_effect.has_method("activation_effect"):
				active_effect.activation_effect(self)
			activation_effect_activated = true
		if _result:
			return _result
		else:
			return null
	else:
		return null
		


