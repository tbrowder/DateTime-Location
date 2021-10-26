[![Actions Status](https://github.com/tbrowder/DateTime-Location/workflows/test/badge.svg)](https://github.com/tbrowder/DateTime-Location/actions)

NAME
====

`DateTime::Location` - Provides location and time data primarily for astronomical programs

WARNING - THIS MODULE IS OBSOLETE AND HAS BEEN REMOVED FROM CPAN
================================================================

It has been broken into two new modules which are much improved:

  * **DateTime::US**

  * **Geo::Location**

`DateTime::Location` is a Work in Progress (WIP). Please file an issue if there are any features you want added. Bug reports (issues) are always welcome.

SYNOPSIS
========

```raku
$ raku
> use DateTime::Location;
> my $loc = Location.new;
> say $loc.name;
Niceville, FL, USA
> say $loc.location;
lat: 30.485092, lon: -86.4376157
```

DESCRIPTION
===========

`DateTime::Location` Provides location and time data primarily for astronomical programs.

See also related modules by the same author:
============================================

  * [`Astro::Almanac`](https://github.com/tbrowder/Astro-Almanac)

  * [`Calendar`](https://github.com/tbrowder/Calendar)

AUTHOR
======

Tom Browder `tom.browder@cpan.org`

COPYRIGHT AND LICENSE
=====================

© 2020 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

