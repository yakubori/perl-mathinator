package Mathinator::Mooed;

use Moo;

my $properties = {
  even      => sub { $_[0] % 2 == 0 },
  negative  => sub { $_[0] < 0 },
  squared   => sub { $_[0] * $_[0]; },
  
  prime => sub {
    my $n = shift;
    
    return '' if $n < 2;

    for ( 2 .. ($n - 1) ) {
      
      return '' if $n % $_ == 0;
    
    }

    return 1;
  },
  
  factorial => sub {
    my $n = shift;
    my $f = 1;

    do { $f *= $_ } for ( 2 .. $n );

    $f;
  },
};

sub _props {

  my ($self, $key) = @_;

  my $p = $properties->{$key};

  # If we have a promise (callback), this is the first time the method has been called.
  # Run it and replace the callback with the return value.
  if ( ref $p eq 'CODE' ) {

    $p = $p->($self->num);
    $properties->{$key} = $p;

  }

  return $p;

}

sub is_even { shift->_props('even') }

sub is_negative { shift->_props('negative') }

sub is_prime { shift->_props('prime') }

sub factorial { shift->_props('factorial') }

sub squared { shift->_props('squared') }

has 'num' => (
  is => 'ro',
  isa => sub { int $_[0] }
);

1;