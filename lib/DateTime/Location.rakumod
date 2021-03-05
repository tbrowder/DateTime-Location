unit class DateTime::Location:ver<0.0.1>:auth<cpan:TBROWDER>;

# at least one of these two attributes must be defined:
has $.name     = "Niceville, FL, USA";  # a convenient display name
has $.id       = 0;                     # a unique id in a collection
# three more mandatory attributes:
has $.lat      =  30.485092;            # decimal degrees: +north, -south
has $.lon      = -86.4376157;           # decimal degrees: +east, -west

has $.timezone = -6; # CST              # non-DST number of hours
                                        # offset from GMT (+east,
                                        # -west), may be a decimal
                                        # fraction
has $.tz       = -6; #    the number (isdst=False)
has $.isdst    = 0;  # dynamically determined

# optional attributes:
has $.city    = "Niceville";
has $.state   = "FL";     # two-letter ISO code
has $.county  = "Okaloosa";
has $.country = "US";   # two-char ISO code
has $.region;    # EU, etc., multi-country area with DST rules
has $.notes;

# DST info which must be calculated according to rules by country, state, or region.
# See the methods below.
has $.dst-start;
has $.dst-end;


# The Daylight Saving Time (DST) values will have to be calculated
# depending on the rules for the area.

# In the US the rules by law are:

# In the EU the rules according
# to Wikipedia are:

submethod TWEAK {
    # ensure mandatory attrs are defined and valid
    my $err = 0;
    my $msg = "FATAL:\n";
    if not ($!id.defined or $!name.defined) {
        ++$err;
        $msg ~= " you must define at least one of \$id or \$name\n";
    }
    elsif $!id eq '' {
        ++$err;
        $msg ~= " \$id cannot be an empty string\n";
    }
    elsif $!name eq '' {
        ++$err;
        $msg ~= " \$name cannot be an empty string\n";
    }
    if not $!lat.defined {
        ++$err;
        $msg ~= " \$lat is not defined\n";
    }

    if not $!lon.defined {
        ++$err;
        $msg ~= " \$lon is not defined\n";
    }
    if not $!timezone.defined {
        ++$err;
        $msg ~= " \$timezone is not defined\n";
    }
    # end check of mandatory defined entries
    if $err {
        die $msg;
    }

    # additional error handling and setup
    $err = 0;
    $msg = "FATAL:\n";

    if not $!id.defined {
        $!id = $!name;
    }
    elsif not $!name.defined {
        $!name = $!id;
    }

    # handle and validate the timezone entry
    # it can be a decimal or a recognized code
    my $tz = $!timezone;
    if $tz ~~ Num {
        if $tz > 12 {
            ++$err;
            $msg ~= " \$timezone must be <= 12 hours"
        }
        elsif $tz < -12 {
            ++$err;
            $msg ~= " \$timezone must be >= -12 hours"
        }
    }
    elsif $tz ~~ Str {
        # for now must be three chars and recognized
        if $tz.chars != 3 {
            ++$err;
            $msg ~= " \$timezone code must be three characters"
        }
        else {
            my ($ret, $e) = self!check-tz-code($tz);
            if $e {
                ++$err;
                $msg ~= " \$timezone must be >= -12 hours"
            }
            else {
                $!timezone = $ret;
            }
        }
    }

    # handle and validate the lat/lon entries
    my ($ret, $e) = self!check-lat-lon($!lat, $!lon);


    # any more errors?
    if $err {
        die $msg;
    }

}

method !check-lat-lon($lat is copy, $lon is copy) {
    my $ret-val = 0;
    my $err     = 0;

    # try all combos

    return $ret-val, $err;
}

method !check-tz-code(Str $tz is copy) {
    # the incoming code is a three-character code and we must know it
    my $ret-val = 0;
    my $err     = 0;
    $tz.= lc;
    given $tz {
        when $_ eq '' { $ret-val = 0 }
        default { $ret-val = 99; ++$err }
    }
    return $ret-val, $err;
}

method lat-dms(:$debug --> Str) {
    # Returns the latitude in DMS format
    my $lat-sym = $.lat >= 0 ?? 'N' !! 'S';
    my $lat-deg = $.lat.truncate.abs;
    my $lat-deg-frac = $.lat.abs - $lat-deg;

    my $lat-min = ($lat-deg-frac * 60.0).round;
    my $lat-min-frac = $lat-deg-frac * 60 - $lat-min;

    my $lat-sec = ($lat-min-frac * 60.0).round;
    return "{$lat-sym}{$lat-deg}d{$lat-min}m{$lat-sec}s";
}

method lon-dms(:$debug --> Str) {
    # Returns the longitude in DMS format
    my $lon-sym = $.lon >= 0 ?? 'E' !! 'W';
    my $lon-deg = $.lon.truncate.abs;
    my $lon-deg-frac = $.lon.abs - $lon-deg;

    my $lon-min = ($lon-deg-frac * 60.0).round;
    my $lon-min-frac = $lon-deg-frac * 60 - $lon-min;

    my $lon-sec = ($lon-min-frac * 60.0).round;
    return "{$lon-sym}{$lon-deg}d{$lon-min}m{$lon-sec}s";
}

method riseset-format(:$debug --> Str) {
    # Returns the format required by the Perl program 'riseset.pl' in
    # CPAN Perl module 'Astro::Montenbruck::RiseSet::RST':
    #
    #   ./script/riseset.pl --place=56N26 37E09 --twilight=civil

    my $lat-sym = $.lat >= 0 ?? 'N' !! 'S';
    my $lon-sym = $.lon >= 0 ?? 'E' !! 'W';

    my $lat-deg = $.lat.truncate.abs;
    my $lon-deg = $.lon.truncate.abs;

    my $lat-min = (($.lat.abs - $lat-deg).abs * 60.0).round;
    my $lon-min = (($.lon.abs - $lon-deg).abs * 60.0).round;

    my $place = "{$lat-deg}{$lat-sym}{$lat-min} {$lon-deg}{$lon-sym}{$lon-min}";
    if 0 or $debug {
        note qq:to/HERE/;
        DEBUG:
        lat = {$.lat}
          lat-deg = {$lat-deg}
          lat-min = {$lat-min}

        lon = {$.lon}
          lon-deg = {$lon-deg}
          lon-min = {$lon-min}

        place: '{$place}'
        HERE
    }
    return $place;
}

sub convert-lat($lat) is export(:convert-lat) {
}

sub convert-lon($lon) is export(:convert-lon) {

}

method location(:$format = 'decimal') {
    if $format ~~ /deg|h/ {
        return "lat: {self.lat-dms}, lon: {self.lon-dms}"
    }
    else {
        return "lat: {self.lat}, lon: {self.lon}"
        #say "TODO: lat/lon in deg/min/sec";
    }
}

