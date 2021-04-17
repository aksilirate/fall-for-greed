class_name Artifacts


const LIST = [
	FallenKingsChaliceCup,
	PrisonersMask,
	LastAngelsRing
]


static func get_random_artifact():
	return LIST[randi() % LIST.size()]
