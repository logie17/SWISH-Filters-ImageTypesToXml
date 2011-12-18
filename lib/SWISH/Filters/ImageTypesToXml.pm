package SWISH::Filters::ImageTypesToXml;
use strict;
use warnings;
use base 'SWISH::Filters::Base';

=head1 NAME

SWISH::Filters::ImageTypesToXml - The great new SWISH::Filters::ImageTypesToXml!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

A SWISHE filter that takes an incoming jpg and analyzes it with Imager::ImageTypes.

=head1 METHODS

=head2 new ( $class )

Constructor. Dynamically loads Imager and Search::Tools::XML. Also sets the
filter mimtype to "image/jpeg".

=cut

sub new {
    my ( $class ) = @_;

    $class = ref $class || $class;

    my $self = bless {
        mimetypes => [qr!image/jpeg!],
    }, $class;

    return $self->use_modules(qw/Imager Search::Tools::XML/);
}

=head2 filter( $self, $doc )

Generates Imager::ImageTypes meta data for indexing.

=cut

sub filter {
    my ( $self, $doc ) = @_;

    my $file        = $doc->fetch_filename;
    my $user_meta   = $doc->meta_data || {};

    my $img         = Imager->new(file=>$file);
    my $utils       = Search::Tools::XML->new;

    my $image_data  = {
        width       => $img->getwidth,
        height      => $img->getheight,
        channels    => $img->getchannels,
        colorcount  => $img->getcolorcount,
        counts      => [$img->getcolorusage],
        %{$user_meta}
    };

    $doc->set_content_type('application/xml');
    my $xml = $utils->perl_to_xml($image_data, 'image_data', );

    return $xml;
}

=head1 AUTHOR

Logan Bell, C<< <loganbell at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-swish-filters-imagetypestoxml at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=SWISH-Filters-ImageTypesToXml>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SWISH::Filters::ImageTypesToXml


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=SWISH-Filters-ImageTypesToXml>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/SWISH-Filters-ImageTypesToXml>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/SWISH-Filters-ImageTypesToXml>

=item * Search CPAN

L<http://search.cpan.org/dist/SWISH-Filters-ImageTypesToXml/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Logan Bell.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of SWISH::Filters::ImageTypesToXml
