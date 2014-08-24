<?php

class ReviewHandler {

	function get() {

		$place = $_GET['place_id'];

		global $config;
		$mysqli = new mysqli($config['mysql_host'], $config['mysql_user'], $config['mysql_pass'], $config['mysql_db']);

		$results_array = array();
		$results_ids = array();

		if ($stmt = $mysqli->prepare("SELECT DISTINCT review_id FROM reviews WHERE place_id = ?")) {
			$stmt->bind_param("s", $place);
			$stmt->execute();
			$stmt->bind_result($review_id);

			while($stmt->fetch()) {
				$results_ids[] = $review_id;
			}

			$stmt->close();

		}

		foreach($results_ids as $review_id) {
			if($sub = $mysqli->prepare("SELECT reviewer, sequence, emoji, review_time FROM reviews WHERE review_id = ? ORDER BY sequence")) {
				$sub->bind_param("s", $review_id);
				$sub->execute();
				$sub->bind_result($reviewer, $sequence, $emoji, $review_time);

				$concat_emoji = "";
				$result_reviewer = "";
				$result_time = "";

				while($sub->fetch()) {
					$concat_emoji = $concat_emoji . $emoji;
					$result_reviewer = $reviewer;
					$result_time = $review_time;
				}

				$results_array[] = array(
					'review_id' => $review_id,
					'place_id' => $place,
					'reviewer' => $result_reviewer,
					'review_time' => $result_time,
					'content' => $concat_emoji
					);

				$sub->close();

			}
		}

		$mysqli->close();

		header('Content-type: application/json');
		echo json_encode($results_array);

	}

	function post() {
		
		global $config;

		$mysqli = new mysqli($config['mysql_host'], $config['mysql_user'], $config['mysql_pass'], $config['mysql_db']);

		// Get JSON body
		$body = json_decode(file_get_contents('php://input'));
		$unique_id = uniqid();

		$sequence = 0;
		foreach($body->emoji as $character) {

			if ($stmt = $mysqli->prepare("INSERT INTO reviews (place_id, review_id, sequence, reviewer, emoji) VALUES (?, ?, ?, ?, ?)")) {
				$stmt->bind_param("ssdss", $body->place_id, $unique_id, $sequence, $body->reviewer, $character);
				$stmt->execute();
				$stmt->close();
			}

			$sequence++;

		}

		$mysqli->close();

	}

}