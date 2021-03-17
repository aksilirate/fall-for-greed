extends ActionLibrary
class_name AcceptOfferAction

const TEXTURE = "res://Textures/Actions/Aceept Offer.png"
const TOOLTIP := "accept the offer"


func _ready():
	acquire_random_artifact()
	reset_location()

