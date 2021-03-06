## Domain Registry Interface, ZACR (ZA Central Registry) GTLD Driver
##
## Copyright (c) 2013 Patrick Mevzek <netdri@dotandco.com>. All rights reserved.
##           (c) 2013 Michael Holloway <michael@thedarkwinter.com>. All rights reserved.
##
## This file is part of Net::DRI
##
## Net::DRI is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## See the LICENSE file that comes with this distribution for more details.
####################################################################################################

package Net::DRI::DRD::ZACR;

use strict;
use warnings;

use base qw/Net::DRI::DRD/;

use DateTime::Duration;

__PACKAGE__->make_exception_for_unavailable_operations(qw/host_update host_current_status host_check host_exist host_delete host_create host_info/);

=pod

=head1 NAME

Net::DRI::DRD::ZACR - ZA Central Registry Driver for Net::DRI

=head1 DESCRIPTION

Additional domain extension ZACR New Generic TLDs. Note this is separate from COZA ccTLD Driver as the systems differ.

ZACR utilises the following standard, and custom extensions. Please see the test files for more examples.

=head2 Standard extensions:

=head3 L<Net::DRI::Protocol::EPP::Extensions::secDNS> urn:ietf:params:xml:ns:secDNS-1.1

=head2 Custom extensions:

=head3 L<Net::DRI::Protocol::EPP::Extensions::COZA::Domain> http://co.za/epp/extensions/cozadomain-1-0

=head1 SUPPORT

For now, support questions should be sent to:

E<lt>netdri@dotandco.comE<gt>

Please also see the SUPPORT file in the distribution.

=head1 SEE ALSO

E<lt>http://www.dotandco.com/services/software/Net-DRI/E<gt>

=head1 AUTHOR

Michael Holloway, E<lt>michael@thedarkwinter.comE<gt>

=head1 COPYRIGHT

Copyright (c) 2013 Patrick Mevzek <netdri@dotandco.com>.
          (c) 2013 Michael Holloway <michael@thedarkwinter.com>.
All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

See the LICENSE file that comes with this distribution for more details.

=cut

####################################################################################################

sub new
{
 my $class=shift;
 my $self=$class->SUPER::new(@_);
 $self->{info}->{host_as_attr}=1;
 $self->{info}->{contact_i18n}=4; ## LOC+INT
 return $self;
}

sub periods  { return map { DateTime::Duration->new(years => $_) } (1); } 
sub name     { return 'ZACR'; }
sub tlds     { return ('cities.dnservices.co.za','joburg','durban','capetown'); } # FIXME : the first is for OT&E tlds, the rest for live.
sub object_types { return ('domain','contact'); }
sub profile_types { return qw/epp/; }

sub transport_protocol_default
{
 my ($self,$type)=@_;

 return ('Net::DRI::Transport::Socket',{},'Net::DRI::Protocol::EPP::Extensions::ZACR',{}) if $type eq 'epp';
 return;
}

####################################################################################################

1;