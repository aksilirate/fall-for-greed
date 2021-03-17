extends ActionLibrary
class_name DeclineOfferAction

const TEXTURE = "res://Textures/Actions/Decline Offer.png"
const TOOLTIP := "decline the offer"



func _ready():
	var emit_story_telling = emit_story_telling("you have declined the offer")
	reset_location()
	yield(emit_story_telling, "completed")
	queue_free()


