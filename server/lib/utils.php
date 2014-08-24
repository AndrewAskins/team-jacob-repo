<?php

// Utilities

// Haversine GC Distance calculator
// Courtesy of http://stackoverflow.com/questions/10053358/measuring-the-distance-between-two-coordinates-in-php

/**
 * Calculates the great-circle distance between two points, with
 * the Haversine formula.
 * @param float $latitudeFrom Latitude of start point in [deg decimal]
 * @param float $longitudeFrom Longitude of start point in [deg decimal]
 * @param float $latitudeTo Latitude of target point in [deg decimal]
 * @param float $longitudeTo Longitude of target point in [deg decimal]
 * @param float $earthRadius Mean earth radius in [m]
 * @return float Distance between points in [m] (same as earthRadius)
 */
function haversineGreatCircleDistance(
	$latitudeFrom, $longitudeFrom, $latitudeTo, $longitudeTo, $earthRadius = 6371000)
{
  // convert from degrees to radians
	$latFrom = deg2rad($latitudeFrom);
	$lonFrom = deg2rad($longitudeFrom);
	$latTo = deg2rad($latitudeTo);
	$lonTo = deg2rad($longitudeTo);

	$latDelta = $latTo - $latFrom;
	$lonDelta = $lonTo - $lonFrom;

	$angle = 2 * asin(sqrt(pow(sin($latDelta / 2), 2) +
		cos($latFrom) * cos($latTo) * pow(sin($lonDelta / 2), 2)));
	return $angle * $earthRadius;
}

function uni_strsplit($string, $split_length=1)
{
	preg_match_all('`.`u', $string, $arr);
	$arr = array_chunk($arr[0], $split_length);
	$arr = array_map('implode', $arr);
	return $arr;
}

// Pretty time -- modified, but courtesy of http://itfeast.blogspot.in/2013/08/php-convert-timestamp-into-facebook.html
function pretty_time($timestamp) {
	$today = time();    
	 $createdday= strtotime($timestamp); //mysql timestamp of when post was created  
	 $datediff = abs($today - $createdday);  
	 $difftext="";  
	 $years = floor($datediff / (365*60*60*24));  
	 $months = floor(($datediff - $years * 365*60*60*24) / (30*60*60*24));  
	 $days = floor(($datediff - $years * 365*60*60*24 - $months*30*60*60*24)/ (60*60*24));  
	 $hours= floor($datediff/3600);  
	 $minutes= floor($datediff/60);  
	 $seconds= floor($datediff);  
	 //year checker  
	 if($difftext=="")  
	 {  
	 	if($years>1)  
	 		$difftext=$years." years ago";  
	 	elseif($years==1)  
	 		$difftext=$years." year ago";  
	 }  
	 //month checker  
	 if($difftext=="")  
	 {  
	 	if($months>1)  
	 		$difftext=$months." months ago";  
	 	elseif($months==1)  
	 		$difftext=$months." month ago";  
	 }  
	 //month checker  
	 if($difftext=="")  
	 {  
	 	if($days>1)  
	 		$difftext=$days." days ago";  
	 	elseif($days==1)  
	 		$difftext=$days." day ago";  
	 }  
	 //hour checker  
	 if($difftext=="")  
	 {  
	 	if($hours>1)  
	 		$difftext=$hours." hours ago";  
	 	elseif($hours==1)  
	 		$difftext=$hours." hour ago";  
	 }  
	 //minutes checker  
	 if($difftext=="")  
	 {  
	 	if($minutes>1)  
	 		$difftext=$minutes." minutes ago";  
	 	elseif($minutes==1)  
	 		$difftext=$minutes." minute ago";  
	 }  
	 //seconds checker  
	 if($difftext=="")  
	 {  
	 	if($seconds>1)  
	 		$difftext=$seconds." seconds ago";  
	 	elseif($seconds==1)  
	 		$difftext=$seconds." second ago";  
	 }  

	 return $difftext;

	}
