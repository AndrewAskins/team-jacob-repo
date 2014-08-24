<?php

class SearchHandler {

	function get() {

		global $config;

		// Defaults
		
		// Lat/long
		if(!isset($_GET['lat'])) {
			$_GET['lat'] = 32.78;
			$_GET['lng'] = -79.93;
		}

		// Radius
		if(!isset($_GET['radius'])) {
			$_GET['radius'] = 2000;
		}

		// Categories
		if(!isset($_GET['categories'])) {
			$_GET['categories'] = 'food|bar|restaurant';
		}

		$base_uri = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?";

		$params = array(
			'key' => $config['google_api_key'],
			'location' => $_GET['lat'] . ',' . $_GET['lng'],
			'radius' => $_GET['radius'],
			'types' => $_GET['categories']
		);

		$full_uri = $base_uri . http_build_query($params);
		$response = \Httpful\Request::get($full_uri)->send();

		// Process response and generate results array
		$results_array = array();

		foreach($response->body->results as $result) {

			// Calculate distance
			$distance = haversineGreatCircleDistance($_GET['lat'], $_GET['lng'], $result->geometry->location->lat, $result->geometry->location->lng) * 0.000621371;

			// Check if there are any top emoji for this location
			$mysqli = new mysqli($config['mysql_host'], $config['mysql_user'], $config['mysql_pass'], $config['mysql_db']);

			$top_emoji = array();

			if ($stmt = $mysqli->prepare("SELECT emoji, count(emoji) FROM reviews WHERE place_id = ? GROUP BY emoji ORDER BY count(emoji) DESC LIMIT 4")) {
				$stmt->bind_param("s", $result->place_id);
				$stmt->execute();
				$stmt->bind_result($emoji, $count);

				while($stmt->fetch()) {
					$top_emoji[] = $emoji;
				}

				$stmt->close();

			}


			$mysqli->close();

			$types_list = array();
			foreach($result->types as $type) {
				$types_list[] = ucfirst($type);
			}

			$temp_result = array(
				'place_id' => $result->place_id,
				'name' => $result->name,
				'categories' => $types_list,
				'distance' => $distance,
				'top_emoji' => $top_emoji,
				'location' => $result->geometry->location,
				'place_details' => $result
				);

			// Get the image reference
			if(isset($result->photos[0]->photo_reference)) {
				$img_base = "https://maps.googleapis.com/maps/api/place/photo?";
				$params = array(
					'maxwidth' => 640,
					'photoreference' => $result->photos[0]->photo_reference,
					'key' => $config['google_api_key']
				);

				$temp_result['img_url'] = $img_base . http_build_query($params);
			}

			// Get the open times
			if(isset($result->opening_hours->open_now)) {
				$temp_result['open_now'] = $result->opening_hours->open_now;
			}

			$results_array[] = $temp_result;
		}
		
		// Output response
		header('Content-type: application/json');
		echo json_encode($results_array);

	}

}