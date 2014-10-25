#!/usr/bin/env perl

use 5.010;
use utf8;
use strict;
use warnings;

use version; our $VERSION = qv('v0.999.1');

use Test::Perl::Critic (
    -severity => 1,
    -profile => 'xt/author/perlcriticrc-code'
);

all_critic_ok( qw< lib bin > );

# setup vim: set filetype=perl tabstop=4 softtabstop=4 expandtab :
# setup vim: set shiftwidth=4 shiftround textwidth=78 nowrap autoindent :
# setup vim: set foldmethod=indent foldlevel=0 :
