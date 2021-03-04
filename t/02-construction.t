use Test;
use DateTime::Location;

plan 5;

# test defaults
my $loc = DateTime::Location.new;
is $loc.lat, 30.485092;
is $loc.lon, -86.4376157;
is $loc.lat-dms, "N30d29m6s";
is $loc.lon-dms, "W86d26m15s";
is $loc.riseset, "30N29 86W26";


