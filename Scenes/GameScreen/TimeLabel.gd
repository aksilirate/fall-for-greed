extends Label

var game_logic = GameLogic.new()

func _on_Story_time_updated(_minutes_passed):
	var _game_minutes = game_logic.get_formatted_time("minute", _minutes_passed)
	var _game_hours = game_logic.get_formatted_time("hour", _minutes_passed)
	var _minutes = "00"
	var _hours = "00"
	
	if _game_minutes > 9:
		_minutes = str(_game_minutes)
	else:
		_minutes = "0" + str(_game_minutes)
	if _game_hours > 9:
		_hours = str(_game_hours)
	else:
		_hours = "0" + str(_game_hours)
		
	text = "day " + str(game_logic.get_formatted_time("day", _minutes_passed)) + " | " + _hours + ":" + _minutes
