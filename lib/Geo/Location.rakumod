unit class DateTime::Location:ver<0.0.1>:auth<cpan:TBROWDER>;

has $.name;
has $.city;
has $.state;
has $.country;   # two-char ISO code
has $.region;    # EU, etc., multi-country area with DST rules
has $.timezone;  # non-DST number of seconds from GMT, same definition as used by DateTime
has $.lat;       # decimal degrees +north, -south
has $.lon;       # decimal degrees +east, -west

# DST info which must be calculated according to rules by country, state, or region.
# See the methods below.
has $.dst-start;
has $.dst-end;

# The Daylight Saving Time (DST) values will have to be calculated depending
# on the rules for the area. 

# In the US the rules by law are:

# In the EU the rules according 
# to Wikipedia are:


