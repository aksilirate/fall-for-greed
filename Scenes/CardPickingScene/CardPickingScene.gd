extends Control

const TAROT_CARDS = [
	EmperorCard,
	HermitCard,
	DeathCard
]

var tarot_cards_cache: Array
var tries_left = 3


func _init():
	visible = false

func _ready():
	tarot_cards_cache = TAROT_CARDS
	$AnimationPlayer.play("Load")
	


func _on_DeckTexture_pressed():
	$AnimationPlayer.play("Draw Card")
	$DeckTexture.modulate.a = 1.0
	tries_left -= 1
	$TriesLeftLabel.text = "tries left: " + str(tries_left)


func _on_CardTexture_pressed():
	$AnimationPlayer.play("Unload")
	

var drawn_card: GDScript
func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Draw Card":
			randomize()
			var _tarot_card_index = round(rand_range(0,tarot_cards_cache.size() - 1))
			drawn_card = tarot_cards_cache[_tarot_card_index]
			tarot_cards_cache.remove(_tarot_card_index)
			$CardTexture.texture = load(drawn_card.TEXTURE)
			$AnimationPlayer.play("Reveal Card")
			
		"Reveal Card":
			$PlaceholderTexture.texture = load(drawn_card.TEXTURE)
			$PlaceholderTexture.hide()
			if not tries_left:
				$AnimationPlayer.play("Unload")
				
		"Unload":
			if get_parent().get("selected_tarot_card"):
				get_parent().animation_player.play("Show Screen")
			else:
				get_parent().animation_player.play("Load")
			get_parent().selected_tarot_card = drawn_card.new()
			queue_free()




