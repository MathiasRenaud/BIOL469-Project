@files = @ARGV;
foreach $file (@files)
{
	open FILE,$file;
	while (<FILE>)
	{	chomp;
		@line = split(/\t/,$_);
		@goTermsLine = ();
		@goTermsLine = split(/\,/,$line[5]);
		foreach $goTerm (@goTermsLine)
		{	
			$goFreq{$goTerm}{$file}++;
		}
	}
}

print "GO";
foreach (@files)
{	print " ",$_; 
}

foreach $go (keys %goFreq)
{	print "\n",$go," ";
	foreach (@files)
	{
		print " ",$goFreq{$go}{$_};
	}
}