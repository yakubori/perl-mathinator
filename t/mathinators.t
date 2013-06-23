#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

BEGIN {
  use_ok('Mathinator');
  use_ok('Mathinator::Mooed');
}

my $m  = Mathinator->new(0);
my $mm = Mathinator::Mooed->new( num => 0 );

isa_ok($m, 'Mathinator');
can_ok($m, $_) for qw(num is_even is_negative is_prime squared factorial);

isa_ok($mm, 'Mathinator::Mooed');
can_ok($mm, $_) for qw(num even negative prime squared factorial);

# Here are the expected returns for a given number 0 - 10.
my @shoulds = (
  {
    num       => 0,
    even      => 1,
    negative  => '',
    prime     => '',
    squared   => 0,
    factorial => 1,
  },
  {
    num       => 1,
    even      => '',
    negative  => '',
    prime     => '',
    squared   => 1,
    factorial => 1,
  },
  {
    num       => 2,
    even      => 1,
    negative  => '',
    prime     => 1,
    squared   => 4,
    factorial => 2,
  },
  {
    num       => 3,
    even      => '',
    negative  => '',
    prime     => 1,
    squared   => 9,
    factorial => 6,
  },
  {
    num       => 4,
    even      => 1,
    negative  => '',
    prime     => '',
    squared   => 16,
    factorial => 24,
  },
  {
    num       => 5,
    even      => '',
    negative  => '',
    prime     => 1,
    squared   => 25,
    factorial => 120,
  },
  {
    num       => 6,
    even      => 1,
    negative  => '',
    prime     => '',
    squared   => 36,
    factorial => 720,
  },
  {
    num       => 7,
    even      => '',
    negative  => '',
    prime     => 1,
    squared   => 49,
    factorial => 5040,
  },
  {
    num       => 8,
    even      => 1,
    negative  => '',
    prime     => '',
    squared   => 64,
    factorial => 40320,
  },
  {
    num       => 9,
    even      => '',
    negative  => '',
    prime     => '',
    squared   => 81,
    factorial => 362880,
  },
  {
    num       => 10,
    even      => 1,
    negative  => '',
    prime     => '',
    squared   => 100,
    factorial => 3628800,
  },
);

my $test = 0;

foreach my $s (@shoulds) {

  my ($even, $fac, $neg, $num, $pri, $sqr) =  map { $s->{$_} }
                                              sort { $a cmp $b }
                                              keys %$s;

  my $mat = Mathinator->new( $test );
  my $moo = Mathinator::Mooed->new( num => $test );
  
  print "\n\n Mathinator \n\n";

  is($mat->num, $num, "$test is $num.");
  is($mat->is_even, $even, "$test is_even() is [$even].");
  is($mat->factorial, $fac, "$test factorial() is [$fac].");
  is($mat->is_negative, $neg, "$test is_negative() is [$neg].");
  is($mat->is_prime, $pri, "$test is_prime() is [$pri].");
  is($mat->squared, $sqr, "$test squared() is [$sqr].");

  print "\n\n Mathinator::Mooed \n\n";

  is($moo->num, $num, "$test is $num.");
  is($moo->even, $even, "$test even() is [$even].");
  is($moo->factorial, $fac, "$test factorial() is [$fac].");
  is($moo->negative, $neg, "$test negative() is [$neg].");
  is($moo->prime, $pri, "$test prime() is [$pri].");
  is($moo->squared, $sqr, "$test squared() is [$sqr].");

  $test++

}

print "\n\n Negatives Tests - Mathinator \n\n";

$m = Mathinator->new(-1);
$mm = Mathinator::Mooed->new( num => -1 );

is($m->num, -1, 'Negative is ok: '.$m->num);
ok($m->is_negative, 'Negative is_negative() is true.');
ok(!$m->is_prime, 'Negative is_prime() is false.');
ok(!$m->is_even, 'Negative is_even() is false for '.$m->num);
is($m->squared, 1, 'Negative squared() is '. $m->squared .' for '. $m->num);
ok(!$m->factorial, 'Negative factorial() is false.');

print "\n\n Negatives Tests - Mathinator::Mooed \n\n";

is($mm->num, -1, 'Negative is ok: '.$m->num);
ok($mm->negative, 'Negative negative() is true.');
ok(!$mm->prime, 'Negative prime() is false.');
ok(!$mm->even, 'Negative even() is false for '.$m->num);
is($mm->squared, 1, 'Negative squared() is '. $m->squared .' for '. $m->num);
ok(!$mm->factorial, 'Negative factorial() is false.');

done_testing();

1;