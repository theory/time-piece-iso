use Module::Build;

my $build = Module::Build->new(
    module_name        => 'Time::Piece::ISO',
    license            => 'perl',
    requires           => { Time::Piece  => '1.01' },
    build_requires     => { Test::Simple => '0.17' },
    create_makefile_pl => 'passthrough',
);
$build->create_build_script;
