<?php

class SimilarHandler {

	function get() {

		$emoji = $_GET['emoji'];

		global $config;

		$mysqli = new mysqli($config['mysql_host'], $config['mysql_user'], $config['mysql_pass'], $config['mysql_db']);

		$results_array = array();
		$temp_results_array = array();

		if ($stmt = $mysqli->prepare("SELECT DISTINCT place_id FROM reviews WHERE emoji = ? ORDER BY review_time DESC")) {
			$stmt->bind_param("s", $emoji);
			$stmt->execute();
			$stmt->bind_result($place_id);

			while($stmt->fetch()) {
				// Get detail view from Google
				$base_uri = "https://maps.googleapis.com/maps/api/place/details/json?";

				$params = array(
					'key' => $config['google_api_key'],
					'placeid' => $place_id
					);

				$full_uri = $base_uri . http_build_query($params);
				$response = \Httpful\Request::get($full_uri)->send();

				$result = $response->body->result;

				$temp_result = array(
					'name' => $result->name,
					'place_id' => $result->place_id,
					'vicinity' => $result->vicinity,
				);

				$temp_results_array[] = $temp_result;
			}

			$stmt->close();

		}

		foreach($temp_results_array as $result) {
			$top_emoji = array();

			if ($stmt = $mysqli->prepare("SELECT emoji, count(emoji) FROM reviews WHERE place_id = ? GROUP BY emoji ORDER BY count(emoji) DESC LIMIT 4")) {
				$stmt->bind_param("s", $result['place_id']);
				$stmt->execute();
				$stmt->bind_result($emoji, $count);

				while($stmt->fetch()) {
					$top_emoji[] = $emoji;
				}

				$stmt->close();

			}

			$result['top_emoji'] = $top_emoji;
			$results_array[] = $result;

		}

		$mysqli->close();

		header('Content-type: application/json');
		echo json_encode($results_array);

	}

}