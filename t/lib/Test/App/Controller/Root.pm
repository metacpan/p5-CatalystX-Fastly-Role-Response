package Test::App::Controller::Root;

use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->config(namespace => '');

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # Hello World
    $c->response->body( 'index page' );
}


sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub page_with_no_caching :Path('page_with_no_caching') {
    my ( $self, $c ) = @_;

    # Should have no effect as we are setting never_cache
    $c->cdn_max_age('1d');
    $c->browser_max_age('1w');

    $c->browser_never_cache(1);
    $c->cdn_never_cache(1);

    $c->response->body( 'No caching here' );
}

sub some_caching :Path('some_caching') {
    my ( $self, $c ) = @_;

    $c->cdn_max_age('10d');
    $c->browser_max_age('1d');

    $c->response->body( 'Browser and CDN cacheing different max ages' );
}

sub end : ActionClass('RenderView') {}


__PACKAGE__->meta->make_immutable;

1;
