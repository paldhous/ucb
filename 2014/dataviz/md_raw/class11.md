# Making interactive maps

https://www.mapbox.com/account/apps/

### Introducing Tilemill




### Make a Tilemill map using the seismic hazard and earthquakes data

Prepare the data.

LibreOffice Calc

```Excel
=SQRT(10^[A2])/200
```

```Excel
=DATE(A2,B2,C2)
```

Sorted by magnitude, descending - important for tooltip.


delete to remove background color
```CSS
Map {
  background-color: #b8dee6;
}
```

Import shapefile, default:

```CSS
#seismicriskclip {
  line-color:#594;
  line-width:0.5;
  polygon-opacity:1;
  polygon-fill:#ae8;
}
```

Edit to:

```CSS
#seismicriskclip {  
  line-width:0;
  polygon-opacity:0.7;
  [ACC_VAL >= 0] { polygon-fill:#fee5d9; }
  [ACC_VAL >= 20] { polygon-fill:#fcae91; }
  [ACC_VAL >= 40] { polygon-fill:#fb6a4a; }
  [ACC_VAL >= 60] { polygon-fill:#de2d26; }
  [ACC_VAL >= 80] { polygon-fill:#a50f15; }
}
```

Import CSV, default:

```CSS
#quakes196420135 {
  marker-width:6;
  marker-fill:#f45;
  marker-line-color:#813;
  marker-allow-overlap:true;
}
```

Edit to:




```CSS
#quakes196420135 {
  marker-width:[amplit]*2;
  marker-fill:#ffffff;
  marker-line-color:#000000;
  marker-allow-overlap:true;
  marker-opacity: 0.5;
  marker-line-opacity: 0.5;
}
```

Legend:
```HTML
strong>Seismic risk:</strong> <br /><br />
Low <span style="color:#fee5d9">▉</span>
<span style="color:#fcae91">▉</span>
<span style="color:#fb6a4A">▉</span>
<span style="color:#de2d26">▉</span>
<span style="color:#a50f15">▉</span> High<br /><br />
Circles show quakes of magnitude 5 or greater, from 1964 to 2013, scaled by the amplitude of ground shaking. Roll over/tap each quake for details.
```


Teaser:
```HTML
<strong>Date:</strong> {{{date}}} <br />
<strong>Magnitude:</strong> {{{mag}}} <br />
<strong>Depth:</strong> {{{depth}}} kilometers
```


```HTML
<!DOCTYPE html>
<html>

<head>

	<meta charset=utf-8 />
	<title>Seismic hazards in the continental U.S.</title>
	<meta name="viewport" content="initial-scale=1,maximum-scale=1,user-scalable=no" />
	<script src="https://api.tiles.mapbox.com/mapbox.js/v2.1.4/mapbox.js"></script>
	<link href="https://api.tiles.mapbox.com/mapbox.js/v2.1.4/mapbox.css" rel="stylesheet" />

	<style>
	  body { margin:0; padding:0; }
	  #map { position:absolute; top:0; bottom:0; width:100%; }
	</style>

</head>

<body>

	<div id="map"></div>

	<script>
		L.mapbox.accessToken = "<Your access token>";

		var map = L.mapbox.map("map", "mapbox.world-print,<Your map>", {maxZoom: 6, minZoom: 4})
			.setView([40, -100], 5);
	</script>

</body>

</html>
```

Mapbox basemaps: http://a.tiles.mapbox.com/v3/mapbox/maps.html

```HTML
<!DOCTYPE html>
<html>

<head>

	<meta charset=utf-8 />
	<title>Seismic hazards in the continental U.S.</title>
	<meta name="viewport" content="initial-scale=1,maximum-scale=1,user-scalable=no" />
	<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
	<link rel="stylesheet" href=" http://leafletjs.com/dist/leaflet.css" />
	<script src="http://leafletjs.com/dist/leaflet.js"></script>
	<script src="src/leaflet.ajax.min.js"></script>
	<script src="src/leaflet-providers.js"></script>
	<script src="src/date-format.js"></script>
	<script src="data/seismic_risk.js"></script>	

	<style>
		body { margin:0; padding:0; }
		#map { position:absolute; top:0; bottom:0; width:100%}
		#legend {
			background: #ffffff;
			position: absolute;
			bottom: 30px;
			right: 10px;
			padding: 0px 10px;
			width: 260px;
			font-family: arial;
			font-size: small;
			-webkit-border-radius:4px 4px 4px 4px;
			border-radius:4px 4px 4px 4px;		
			-webkit-box-shadow: 0px 1px 5px rgba(153,153,153,1);
			-moz-box-shadow: 0px 1px 5px rgba(153,153,153,1);
			box-shadow: 0px 1px 5px rgba(153,153,153,1)
		}
	</style>

</head>

<body>

	<div id="map">

		<script src="maps.js"></script>

	</div>

	<div id="legend">

		<p><strong>Seismic risk:</strong></p>
		<p>Low
		<span style="color:#fee5d9">▉</span>
		<span style="color:#fcae91">▉</span>
		<span style="color:#fb6a4A">▉</span>
		<span style="color:#de2d26">▉</span>
		<span style="color:#a50f15">▉</span>
		High</p>
		<p>Circles show quakes of magnitude 5 or greater, from 1965 to present, scaled by the amplitude of ground shaking. Click on each quake for details.</p>

	</div>

</body>

</html>
```
And here is `maps.js`:

```Javascript
var earth = L.tileLayer.provider("MapQuestOpen.Aerial");

var bwmap = L.tileLayer("https://{s}.tiles.mapbox.com/v3/mapbox.world-print/{z}/{x}/{y}.png", {
	attribution: "<a href='http://www.mapbox.com/about/maps/' target='_blank'>Terms &amp; Feedback</a>"
});

function getColor(a) {
			return a > 79 ? "#a50f15":
				   a > 59 ? "#de2d26" :
				   a > 39  ? "#fb6a4A" :
				   a > 19 ? "#fcae91" :
				   "#fee5d9";	
		}
		
function style(feature) {
				return {
					fillColor: getColor(feature.properties.ACC_VAL),
					color: getColor(feature.properties.ACC_VAL),
					weight: 1,
					opacity: 0.4,
					fillOpacity: 0.7
				};
			}

// var seismic = L.geoJson(seismic_risk);

var seismic = L.geoJson(seismic_risk, {style:style});

var quakedataUrl = "http://comcat.cr.usgs.gov/fdsnws/event/1/query?starttime=1965-01-01T00:00:00&minmagnitude=5&format=geojson&latitude=39.828175&longitude=-98.5795&maxradiuskm=6000&orderby=magnitude&callback="

var quakes = L.geoJson.ajax(quakedataUrl, {

			dataType:"jsonp",
						
			onEachFeature: popupText,
			
			pointToLayer: function (feature, latlng) {
				return L.circleMarker(latlng, {
					radius: Math.sqrt(Math.pow(10, feature.properties.mag)/50000),
					fillColor: "#fff",
					color: "#000",
					weight: 1,
					opacity: 0.2,
					fillOpacity: 0.5
				});
			}
			});

function  popupText (feature, layer) {
	 var date = new Date(feature.properties.time)
	 var dateString = date.format("mmm d, yyyy")
	 layer.bindPopup("<strong>Date: </strong>" + dateString + "<br />"
					+ "<strong>Magnitude: </strong>" + feature.properties.mag + "<br />"
					+ "<strong>Depth: </strong>" + feature.geometry.coordinates[2] + " kilometers")
}

var map = L.map("map", {
	center: new L.LatLng(40, -100),
	zoom: 5, 
	maxZoom: 6,
	minZoom: 4,
	maxBounds: ([
	[-10, -160],
	[70, -40]
	]),
	layers: [bwmap, seismic, quakes] 
});

var baseMaps = {
	"Satellite": earth,
	"Map": bwmap
};

var overlayMaps = {
	"Earthquakes": quakes,
	"Seismic risk": seismic
};

var layersControl = new L.Control.Layers(baseMaps, overlayMaps, {collapsed: false});
map.addControl(layersControl);



```







