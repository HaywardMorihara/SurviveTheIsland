extends Control

func _ready():
	yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
	$ScoreSubmissionStatus.visible = false
	$NameLineEdit.visible = true
	$SubmitScoreButton.visible = true

func _on_SubmitScoreButton_pressed():
	var player_name = $NameLineEdit.text
	if not player_name:
		# Ideally we'd print an error here or something but I'm lazy...
		return
		
	$NameLineEdit.visible = false
	$SubmitScoreButton.visible = false
	$ScoreSubmissionStatus.visible = true
	$ScoreSubmissionStatus.text = "Submitting..."
	
	$LeaderboardTimeout.start()
	var score_id = yield(SilentWolf.Scores.persist_score(player_name, Global.coins_collected), "sw_score_posted")
	$ScoreSubmissionStatus.text = "Score submitted!"
	$Leaderboard.visible = true


func _on_LeaderboardTimeout_timeout():
	if not SilentWolf.Scores.scores:
		$ScoreSubmissionStatus.text = "Error: Trouble connecting to leaderboard"
