#!perl -w

# $Id: zpod.t,v 1.1 2003/08/26 05:23:58 david Exp $

use Test::More;
use File::Spec;
use File::Find;
use strict;

eval "use Test::Pod 0.95";

if ($@) {
    plan skip_all => "Test::Pod v0.95 required for testing POD";
} else {
    Test::Pod->import;
    my @files;
    my $blib = File::Spec->catfile(qw(blib lib));
    find( sub {push @files, $File::Find::name if /\.p(l|m|od)$/}, $blib);
    plan tests => scalar @files;
    foreach my $file (@files) {
        pod_file_ok($file);
    }
}
