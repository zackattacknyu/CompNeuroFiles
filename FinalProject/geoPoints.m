%{
This gets us the geographical points for our cities
Found though link on wikipedia to geographical coordinates

1. New York: 40.728333,-73.994167
2. Chicago: 41.836944,-87.684722
3. Los Angeles: 34.05,-118.25
4. Seattle: 47.609722,-122.333056
5. Atlanta: 33.755,-84.39
6. Denver: 39.76185,-104.881105


7. Amsterdam: 52.366667,4.9
8. Berlin: 52.516667,13.383333
9. Prague: 50.083333,14.416667
10. Paris: 48.8567,2.3508
11. Munich: 48.133333,11.566667
12. Vienna: 48.2,16.366667
13. Warsaw: 52.233333,21.016667

%}

allCities = [
40.728333,-73.994167;
41.836944,-87.684722;
34.05,-118.25;
47.609722,-122.333056;
33.755,-84.39;
39.76185,-104.881105;
52.366667,4.9;
52.516667,13.383333;
50.083333,14.416667;
48.8567,2.3508;
48.133333,11.566667;
48.2,16.366667;
52.233333,21.016667];

citiesToInclude = [1 3 4];
citiesLatLong = allCities(citiesToInclude,:);

citiesLat = citiesLatLong(:,1);
citiesLong = citiesLatLong(:,2);


latRange = max(citiesLat)-min(citiesLat);
longRange = max(citiesLong)-min(citiesLong);
range = max(latRange,longRange);
citiesLat = (citiesLat-min(citiesLat))./range;
citiesLong = (citiesLong-min(citiesLong))./range;

%put in -1 to 1 range
citiesLat = 2*citiesLat;
citiesLat = citiesLat-0.5*(max(citiesLat)-min(citiesLat));
citiesLong = 2*citiesLong;
citiesLong = citiesLong-0.5*(max(citiesLong)-min(citiesLong));

shrink = 0.8; %ensures that reward center is not at exact edge
citiesLat = citiesLat.*shrink;
citiesLong = citiesLong.*shrink;

plot(citiesLong,citiesLat,'rx');
axis equal