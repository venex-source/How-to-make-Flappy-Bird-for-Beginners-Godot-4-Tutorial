extends TextureButton

signal startGame

@onready var banner: = get_node("Banner")
@onready var score_container: = get_node("ScoreContainer")
@onready var game_over_message: = get_node("GameOver")
@onready var point_score_container: = get_node("ScorePanel/PointScoreContainer")
@onready var best_score_container: = get_node("ScorePanel/BestScoreContainer")

var score = 0
var best_score = 0

func _on_pressed():
	disabled = true
	banner.hide()
	startGame.emit()

func _on_restart_button_pressed():
	get_tree().reload_current_scene()

func _on_score_updated():
	score += 1
	score_container.update_score(score)

func gameover_display() -> void:
	game_over_message.show()
	await get_tree().create_timer(2.0).timeout
	game_over_message.hide()
	score_container.hide()
	$ScorePanel.show()
	$DeathSound.play()
	point_score_container.update_score(score)
	if best_score < score or !score:
		best_score_container.update_score(score)
