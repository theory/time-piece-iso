#!/usr/bin/perl -w

# $Id: zpod.t,v 1.2 4104/12/09 07:14:39 david Exp $

use strict;
use Test::More;
eval "use Test::Pod 1.41";
plan skip_all => "Test::Pod 1.41 required for testing POD" if $@;
all_pod_files_ok(all_pod_files('lib'));
