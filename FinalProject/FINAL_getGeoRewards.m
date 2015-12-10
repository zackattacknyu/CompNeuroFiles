function [ rewards,citiesRew ] = FINAL_getGeoRewards( citiesToInclude, shrink )
%FINAL_GETGEOPOINTS Summary of this function goes here
%   Detailed explanation goes here

%{
This gets us the geographical points for our cities
Found though link on wikipedia to geographical coordinates
Population data from wikipedia
Coordinates in signed degrees format

1. New York: 40.728333,-73.994167; 8.5 million
2. Chicago: 41.836944,-87.684722; 2.7 million
3. Los Angeles: 34.05,-118.25; 3.9 million
4. Seattle: 47.609722,-122.333056; 0.6 million
5. Atlanta: 33.755,-84.39; 0.5 million
6. Denver: 39.76185,-104.881105; 0.6 million


7. Amsterdam: 52.366667,4.9; 0.8 million
8. Berlin: 52.516667,13.383333; 3.56 million
9. Prague: 50.083333,14.416667; 1.26 million
10. Paris: 48.8567,2.3508; 2.24 million
11. Munich: 48.133333,11.566667; 1.4 million
12. Vienna: 48.2,16.366667; 1.8 million
13. Warsaw: 52.233333,21.016667; 1.7 million

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

allCitiesPop=[
    8.5;
    2.7;
    3.9
    0.6;
    0.5;
    0.6;
    0.8;
    3.56;
    1.26;
    2.24;
    1.4;
    1.8;
    1.7];

%citiesToInclude = [1 2 3 4 5]; %for D
%citiesToInclude = [8 12 13]; %for 2
citiesLatLong = allCities(citiesToInclude,:);
citiesPop = allCitiesPop(citiesToInclude);

%gets reward values based on population
citiesRew = (citiesPop-min(citiesPop))./(max(citiesPop)-min(citiesPop));
citiesRew = citiesRew./2 + 0.5;

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

%shrink = 0.5; %ensures that reward center is not at exact edge
citiesLat = citiesLat.*shrink;
citiesLong = citiesLong.*shrink;

%plot(citiesLong,citiesLat,'rx');
%axis equal

rewards = [citiesLong citiesLat];
end

