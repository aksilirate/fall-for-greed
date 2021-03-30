extends Control


const TAROT_CARDS = [
	EmpressCard,
	EmperorCard,
	HermitCard,
	StrengthCard,
	FoolCard,
	DeathCard
]

var tarot_cards_cache: Array
var tries_left = 3


func _init():
	visible = false

func _ready():
	randomize()
	tarot_cards_cache = [] + TAROT_CARDS
	tarot_cards_cache.shuffle()
	if tarot_cards_cache[0].get("DEATH"):
		tarot_cards_cache.invert()
	
	$AnimationPlayer.play("Load")
	


func _on_DeckTexture_pressed():
	$AnimationPlayer.play("Draw Card")
	$DeckTexture.modulate.a = 1.0
	tries_left -= 1


func _on_CardTexture_pressed():
	$AnimationPlayer.play("Unload")
	

var drawn_card: GDScript
func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Draw Card":
			drawn_card = tarot_cards_cache.pop_front()
			$CardTexture.texture = load(drawn_card.TEXTURE)
			$AnimationPlayer.play("Reveal Card")
			
		"Reveal Card":
			$PlaceholderTexture.texture = load(drawn_card.TEXTURE)
			$PlaceholderTexture.hide()
			if not tries_left:
				$AnimationPlayer.play("Unload")
				
		"Unload":

			if get_parent().get("selected_tarot_card"):
				get_parent().selected_tarot_card = drawn_card.new()
				get_parent().animation_player.play("Show Screen")
			else:
				get_parent().selected_tarot_card = drawn_card.new()
				get_parent().animation_player.play("Load")
				
			
			queue_free()




