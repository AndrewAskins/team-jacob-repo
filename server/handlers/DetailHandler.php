<?php

class DetailHandler {

	function get() {

		$place = $_GET['place_id'];

		global $config;

		// Get detail view from Google
		$base_uri = "https://maps.googleapis.com/maps/api/place/details/json?";

		$params = array(
			'key' => $config['google_api_key'],
			'placeid' => $place
		);

		$full_uri = $base_uri . http_build_query($params);
		$response = \Httpful\Request::get($full_uri)->send();

		$result = $response->body->result;

		$temp_result = array(
			'address' => $result->formatted_address,
			'phone' => $result->formatted_phone,
			'vicinity' => $result->vicinity,
			'url' => $result->url
		);

		// Get the open times
		if(isset($result->opening_hours)) {
			$temp_result['open_now'] = $result->opening_hours->open_now;
			$temp_result['open_periods'] = $result->opening_hours->periods;
		}

		$mysqli = new mysqli($config['mysql_host'], $config['mysql_user'], $config['mysql_pass'], $config['mysql_db']);

		$results_array = array();
		$results_ids = array();

		if ($stmt = $mysqli->prepare("SELECT DISTINCT review_id FROM reviews WHERE place_id = ? ORDER BY review_time DESC")) {
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

				$concat_emoji = array();
				$result_reviewer = "";
				$result_time = "";

				while($sub->fetch()) {
					$concat_emoji[] = $emoji;
					$result_reviewer = $reviewer;
					$result_time = $review_time;
				}

				$results_array[] = array(
					'review_id' => $review_id,
					'place_id' => $place,
					'reviewer' => $result_reviewer,
					'review_time' => $result_time,
					'review_time_pretty' => pretty_time($result_time),
					'content' => $concat_emoji
					);

				$sub->close();

			}
		}

		$mysqli->close();

		$temp_result['reviews'] = $results_array;

		header('Content-type: application/json');
		echo json_encode($temp_result);

	}

}