use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Time::Piece::ISO',
    'VERSION_FROM'	=> 'lib/Time/Piece/ISO.pm', # finds $VERSION
    'PREREQ_PM'		=> {Time::Piece => "1.01" }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'lib/Time/Piece/ISO.pm', # retrieve abstract from module
       AUTHOR     => 'David Wheeler <david@wheeler.net>') : ()),
);
