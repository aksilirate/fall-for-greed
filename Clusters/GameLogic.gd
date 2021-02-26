class_name GameLogic



func get_formatted_time(_type, _minutes_passed):
	var _day = floor(_minutes_passed / 1440)
	var _hour = floor((_minutes_passed - (1440 * _day)) / 60)
	var _minute = _minutes_passed - (60*_hour) - (1440 * _day)
	match _type:
		"day":
			return _day + 1
		"hour":
			return _hour
		"minute":
			return _minute
