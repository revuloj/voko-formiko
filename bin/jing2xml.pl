#!/usr/bin/perl -w

my $jing_file = shift @ARGV ||
  die "Necesas doni jing-eraro-dosieron sur komandlinio: $!\n";

my $xml_dir = "./xml";
my $ERROR_PREFIX = '^/([^:]+\.xml):([\d]+):([\d]+):';

open IN, $jing_file ||
  die "Ne povis legi $jing_file: $!\n";

print "<xml>\n";

while (<IN>) {
  if (m|$ERROR_PREFIX\s+(.*)|) {
	my $file = $1;
	my $line = $2;
	my $col = $3;
	my $error = $4;
	output_error($file,$line,$col,$error);
  } elsif (not eof(IN)) {
	die "Okazis eraro, atendis dosiernomon, sed trovis: \"$_\"\n";
  }	
};

close IN;

my $date = `date +"%Y-%m-%d %H:%M"`;

print "<date>$date</date></xml>";

sub output_error {
  my ($file,$line,$col,$error) = @_;
  $file = m|/([^/]+)\.xml|;
  my $art = $1;
  print "<eraro dos='$art' lin='$line' kol='$col'>$error</eraro>\n";
}

