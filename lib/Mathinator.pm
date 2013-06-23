package Mathinator;

use strict;
use warnings;

sub new {
  
  my $class = shift;
  my $num   = int shift;

  # Closures which are to be lazily evaluated and ultimately replaced by their respective
  # return values.
  #
  # This is an example of how we can save compute resources via promises and memoization.
  my $properties = {
    
    even      => sub { $num % 2 == 0 },
    negative  => sub { $num < 0 },
    squared   => sub { $num * $num },
    
    factorial => sub {

      my $f = 1;

      do { $f *= $_ } for ( 2 .. $num );

      return $f;

    },
    
    prime => sub {

      return '' if $num < 2;

      for ( 2 .. ($num - 1) ) {
        
        return '' if $num % $_ == 0;
      
      }

      return 1;

    },
  
  };

  my $self = {
    
    num        => $num,
    properties => $properties,

  };

  bless $self, $class;

}

sub _props {

  my ($self, $key) = @_;

  my $props = $self->{properties}->{$key};

  # If we have a promise (callback), this is the first time the method has been called.
  # Run it and replace the callback with the return value.
  if ( ref $props eq 'CODE' ) {

    $props = $props->();
    $self->{properties}->{$key} = $props;

  }

  return $props;

}

sub is_even { shift->_props('even') }

sub is_negative { shift->_props('negative') }

sub is_prime { shift->_props('prime') }

sub factorial { shift->_props('factorial') }

sub squared { shift->_props('squared') }

1;