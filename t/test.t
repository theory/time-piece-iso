#!/usr/bin/perl -w

use strict;
use Test;
use constant DEBUG => 0;
BEGIN { plan tests => 18 };
use Time::Piece::ISO;
ok(1); # If we made it this far, we're ok.

# Try base class functionality.
ok(my $t = gmtime(315532800)); # 00:00:00 1/1/1980
ok(! $t->hour);
ok($t->mon == 1);
ok(UNIVERSAL::isa(localtime, 'Time::Piece'));
ok(UNIVERSAL::isa(localtime, 'Time::Piece::ISO'));
ok(UNIVERSAL::isa(gmtime, 'Time::Piece'));
ok(UNIVERSAL::isa(gmtime, 'Time::Piece::ISO'));

# Try new functionality.
ok( $t = Time::Piece::ISO->new(315532800)); # 00:00:00 1/1/1980
ok( my $t2 = localtime(315532800));
ok(($t <=> $t2) == 0);
ok(($t cmp $t2) == 0);
# cmp operator.

ok($t = gmtime(315532800)); # 00:00:00 1/1/1980
ok(($t cmp "1980-01-01T00:00:00") == 0);
ok(($t cmp "1990-01-01T00:00:00") == -1);
ok(($t cmp "1970-01-01T00:00:00") == 1);
# String operator and iso() method.
ok("$t" eq "1980-01-01T00:00:00");
ok($t->iso eq "1980-01-01T00:00:00");

