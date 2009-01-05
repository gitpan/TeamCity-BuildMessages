#!/usr/bin/env perl

use 5.010;
use utf8;
use strict;
use warnings;


use autodie qw< :default >;
use Readonly;


use version; our $VERSION = qv('v0.999.1');


use TeamCity::BuildMessages qw< teamcity_escape >;


use Test::More;


Readonly my @TEST_INPUT_AND_EXPECTED => (
    [ [ qw/ foo [bar] / ],                            q<foo '[bar|]'>                            ],
    [ [ qw/ progressMessage <message> / ],            q[progressMessage '<message>']             ],
    [ [ qw/ buildNumber 1.2.3_{build.number}-ent / ], q<buildNumber '1.2.3_{build.number}-ent'>, ],
    [ [ qw/ foo bar [baz] / ],                        q<foo bar='[baz|]'>                        ],
    [ [ qw/ testStdErr name testname out text / ],    q<testStdErr name='testname' out='text'>   ],
);

plan tests => scalar @TEST_INPUT_AND_EXPECTED;


foreach my $values (@TEST_INPUT_AND_EXPECTED) {
    my ($input, $expected) = @{$values};
    my @input = @{$input};
    $expected = qq/##teamcity[$expected]\n/;

    my $got = q<>;
    open my $string_handle, '>', \$got;
    TeamCity::BuildMessages::_emit_build_message_to_handle(
        $string_handle, @input,
    );
    close $string_handle;

    is( $got, $expected, qq<_emit_build_message_to_handle(@input)> );
} # end foreach


# setup vim: set filetype=perl tabstop=4 softtabstop=4 expandtab :
# setup vim: set shiftwidth=4 shiftround textwidth=78 nowrap autoindent :
# setup vim: set foldmethod=indent foldlevel=0 :
