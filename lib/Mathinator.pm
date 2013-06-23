package Mathinator;

use strict;
use warnings;

use Memoize;

memoize( qw(is_even is_negative is_prime squared factorial) );

sub new {
  
  my $class = shift;
  my $num   = int shift;

  my $self = { num => $num };

  bless $self, $class;

}

sub num { shift->{num} }

sub is_even { shift->{num} % 2 == 0 }

sub is_negative { shift->{num} < 0 }

sub squared { 
  my $n = shift->{num};

  $n * $n;
}

sub is_prime {
  my $n = shift->{num};

  return '' if $n < 2;

  for ( 2 .. ($n - 1) ) {
    
    return '' if $n % $_ == 0;
  
  }

  1;
}

sub factorial {
  my $n = shift->{num};

  return '' if $n < 0;
  
  my $f = 1;

  do { $f *= $_ } for ( 2 .. $n );

  $f;
}

1;
