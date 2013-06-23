package Mathinator::Mooed;

use Carp qw(croak);
use Memoize;
use Moo;

memoize( qw(_build_even _build_negative _build_prime factorial squared) );

sub BUILDARGS {

  my ($class, %args) = @_;

  # We don't want anyone messing with certain attributes on instantiation.
  do { croak "Cannot set $_" if exists $args{$_} } for qw(even negative prime);

  return \%args;

}

has 'num' => (
  is => 'ro',
  isa => sub { int $_[0] }
);

has 'even' => ( is => 'lazy' );
has 'negative' => ( is => 'lazy' );
has 'prime' => ( is => 'lazy' );

sub _build_even { shift->num % 2 == 0 }

sub _build_negative { shift->num < 0 }

sub squared {
  my $n = shift->num;
  $n * $n;
}

sub _build_prime {
  my $n = shift->num;
        
  return '' if $n < 2;

  for ( 2 .. ($n - 1) ) { return '' if $n % $_ == 0 }

  1;
}

sub factorial {
  my $n = shift->num;

  return '' if $n < 0;
  
  my $f = 1;

  do { $f *= $_ } for ( 2 .. $n );

  $f;
}

1;
