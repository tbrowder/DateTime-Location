[![Actions Status](https://github.com/tbrowder/DateTime-Location/workflows/test/badge.svg)](https://github.com/tbrowder/DateTime-Location/actions)

NAME
====

DateTime::Location - Provides location and time data primarily for astronomical programs

SYNOPSIS
========

```raku
$ raku
> use DateTime::Location;
> my $loc = Location.new;
> say $loc.name;
Niceville, FL, USA
> say $loc.location;
lat: ?, lon: ?
```

DESCRIPTION
===========

`DateTime::Location` is a Work in Progress (WIP)

See also
========

  * `Astro::Almanac`

  * `Calender`

AUTHOR
======

Tom Browder `tom.browder@cpan.org`

COPYRIGHT AND LICENSE
=====================

© 2020 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

