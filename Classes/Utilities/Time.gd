class_name Time



static func get_formatted_time(_type, _minutes_passed):
	var _day = floor(_minutes_passed / 1440.0)
	var _hour = floor((_minutes_passed - (1440.0 * _day)) / 60)
	var _minute = _minutes_passed - (60*_hour) - (1440.0 * _day)
	match _type:
		"day":
			return _day
		"hour":
			return _hour
		"minute":
			return _minute
