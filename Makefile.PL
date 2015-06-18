use inc::Module::Install;

name     'SWISH-Filters-ImageTypesToXml';
all_from 'lib/SWISH/Filters/ImageTypesToXml.pm';
author   q{Logan Bell <loganbell@gmail.com>};
license  'perl';

requires 'SWISH::Filter'                    => 0;
requires 'SWISH::Filter::MIMETypes'         => 0;
requires 'Imager'                           => 0;
requires 'Search::Tools::XML'               => 0;
requires 'MIME::Base64'                     => 0;
requires 'XML::Simple'                      => 0;
test_requires 'Test::More';
test_requires 'Test::MockObject';
test_requires 'File::Slurp';

repository 'git://github.com/logie17/SWISH-Filters-ImageTypesToXml.git';

auto_install;

WriteAll;

