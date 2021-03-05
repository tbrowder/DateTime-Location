use Test;
use DateTime::Location;

plan 14;

# test defaults
my $loc = DateTime::Location.new;

is $loc.lat, 30.485092;
is $loc.lon, -86.4376157;
is $loc.lat-dms, "N30d29m6s";
is $loc.lon-dms, "W86d26m15s";
is $loc.riseset-format, "30N29 86W26";
is $loc.city, "Niceville";
is $loc.state, "FL";
is $loc.country, "US";
is $loc.county, "Okaloosa";
is $loc.id, 0;
is $loc.name, "Niceville, FL, USA";
is $loc.tz, -6;
is $loc.location, "lat: 30.485092, lon: -86.4376157";
is $loc.location(:format<deg>), "lat: N30d29m6s, lon: W86d26m15s";

