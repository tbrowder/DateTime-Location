unit class DateTime::Location:ver<0.0.1>:auth<cpan:TBROWDER>;

# at least one these two attributes must be defined:
has $.name;      # a convenient display name
has $.id;        # a unique id in a collection
# three more mandatory attributes:
has $.lat;       # decimal degrees: +north, -south
has $.lon;       # decimal degrees: +east, -west
has $.timezone;  # non-DST number of hours offset from GMT (+east, -west), may be a decimal fraction

# optional attributes:
has $.city;
has $.state;     # two-letter ISO code
has $.county;
has $.country;   # two-char ISO code
has $.region;    # EU, etc., multi-country area with DST rules
has $.notes;

# DST info which must be calculated according to rules by country, state, or region.
# See the methods below.
has $.dst-start;
has $.dst-end;

# The Daylight Saving Time (DST) values will have to be calculated depending
# on the rules for the area. 

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

method city($city) {
}

