use inc::Module::Install;

name     'SWISH-Filters-ImageTypesToXml';
all_from 'lib/SWISH/Filters/ImageTypesToXml.pm';
author   q{Logan Bell <loganbell@gmail.com>};
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

