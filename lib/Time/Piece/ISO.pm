package Time::Piece::ISO;

use strict;
use vars qw($VERSION @ISA @EXPORT %EXPORT_TAGS);
use Time::Piece ();
require Exporter;

@ISA = qw(Time::Piece Exporter);

@EXPORT = @Time::Piece::EXPORT;
%EXPORT_TAGS = %Time::Piece::EXPORT_TAGS;

$VERSION = "0.04";

use overload '""' => \&iso,
             cmp  => \&str_compare;

#sub iso { $_[0]->SUPER::datetime(date => '-', time => ':', T => 'T' ) }
sub iso { $_[0]->SUPER::datetime }

sub str_compare {
    my ($lhs, $rhs, $reverse) = @_;
    if (UNIVERSAL::isa($rhs, 'Time::Piece')) {
        $rhs = "$rhs";
    }
    return $reverse ? $rhs cmp $lhs->datetime : $lhs->datetime cmp $rhs;
}

# Rebless into this class.
sub localtime { bless &Time::Piece::localtime, __PACKAGE__ }
sub gmtime { bless &Time::Piece::gmtime, __PACKAGE__ }

1;
__END__

=pod

=head1 NAME

Time::Piece::ISO - ISO 8601 Subclass of Time::Piece

=head1 SYNOPSIS

  use Time::Piece::ISO;

  my $t = localtime;
  print "Time is $t\n"; # prints "Time is 2002-04-25T21:17:52"
  print "Year is ", $t->year, "\n";

=head1 DESCRIPTION

This module subclasses Time::Piece in order to change its stringification
and string comparison behavior to use the ISO 8601 format instead of
localtime's ctime format. Although it does break the backwards compatibility
with the builtin localtime and gmtime functions that Time::Piece offers,
Time::Piece::ISO is designed to promote the more standard ISO format as a
new way of handling dates.

I decided to create this module for two simple reasons: First, default
support for the ISO 8601 date format seems to be the direction in which Perl
6 is heading. And second, the ISO 8601 format tends to be more widely
compatible with RDBMS date time column type formats.

=head1 EXPORT

Like Time::Piece, Time::Piece::ISO exports two functions by default. These
are localtime() and gmtime(), and they replace the builtin functions with
the same names. The return values of these functions are Time::Piece::ISO
objects, and they work exactly like Time::Piece objects except that, in a
double-string context, they output an ISO 8601 formatted date string rather
than the default L<ctime>(3) value.

  my $t = gmtime;
  print "Time is $t\n"; # prints "Time is 2002-04-25T21:17:52"

By extension of the double-quoted string context, Time::Piece::ISO objects
also use the ISO 8601 format for string (C<cmp>) comparisons.

This does break backward compatibility with the builtin versions of the
functions, so if you'd like to use Time::Piece::ISO objects while preserving
the old functionality of localtime() and gmtime(), import Time::Piece::ISO
without importing any of its functions:

  use Time::Piece::ISO ();

=head1 METHODS

Time::Piece::ISO adds one method to the many already offered by Time::Piece.
The iso() method acts as a synonym for Time::Piece's datetime() method, but
is guaranteed to always return a strict ISO 8601 date string.

  my $t = localtime;
  print "Time is ", $t->iso, "\n"; # prints "Time is 2002-04-25T21:17:52"

=head1 OVERLOADING

All operator overloading offered by Time::Piece remains in place. Only the
C<cmp> and double-quoted string operators have been overloaded by
Time::Piece::ISO. This is so that it will evaluate and and compare the time
only in an ISO 8601 format rather than the ctime date format used by the
Time::Piece.

=head1 AUTHOR

David Wheeler <david@wheeler.net>, extending Matt Seargent's
<matt@seargent.org> L<Time::Piece|Time::Piece> module.

=head1 SEE ALSO

L<Time::Piece|Time::Piece>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2000-2002, David Wheeler. All Rights Reserved.

This module is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut
