extends Label

func _ready():
# warning-ignore:return_value_discarded
	Game.connect("minutes_passed_updated", self, "_on_minutes_passed_updated")

func _on_minutes_passed_updated():
	var time_left = max(BalanceData.WITCH_SPAWN_MINUTE - Game.minutes_passed, 0.0)
	var _minutes_left = Time.get_formatted_time("minute", time_left)
	var _hours_left = Time.get_formatted_time("hour", time_left)
	var _days_left = Time.get_formatted_time("day", time_left)
	
	var _minutes: String
	var _hours: String
	var _days: String
	
	
	
	if _minutes_left > 1:
		_minutes = str(_minutes_left) + "m"
	elif _minutes_left > 1:
		_minutes = str(_minutes_left) + "m"
	else:
		_minutes = ""

		
	if _hours_left > 1:
		_hours = str(_hours_left) + "h   "
	elif _hours_left == 1:
		_hours = str(_hours_left) + "h   "
	else:
		_hours = ""
		
	if _days_left > 1:
		_days = str(_days_left) + "d   "
	elif _days_left == 1:
		_days = str(_days_left) + "d   "
	else:
		_days = ""
		

	
	text = _days + _hours + _minutes
