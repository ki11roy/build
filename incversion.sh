#!/usr/bin/perl
use Tie::File;

my $version;

tie @lines, 'Tie::File', "CMakeLists.txt" or die "Can't read file: $!\n";

foreach (@lines)
{
    if(s/(SET(.*)VERSION (.*)(\d+).(\d+).(\d+)(.*))/"SET$2VERSION $3$4.$5.".($6+1)."$7"/e)
    {
        $version = "$4.$5." . ($6 + 1);
        print "CMakeLists.txt: Version successfully switched to: $version\n";
        print "Committing & pushing...\n";
        system('git', 'add', 'CMakeLists.txt');
        system('git', 'commit', '-m', "v$version");
        system('git', 'tag', '-a', "v$version", '-m', "version $version");
        system('git', 'push');
        system('git', 'push', '--tags');
        last;
    }
}

