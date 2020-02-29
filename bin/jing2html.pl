#!/usr/bin/perl -w

my $jing_file = shift @ARGV ||
  die "Necesas doni jing-eraro-dosieron sur komandlinio: $!\n";

my $xml_dir = "./xml";
my $ERROR_PREFIX = '^/([^:]+\.xml):([\d]+):([\d]+):';

open IN, $jing_file ||
  die "Ne povis legi $jing_file: $!\n";

print <<EOH;
<html>
  <head><title>Strukturaj neregulaĵoj trovitaj per RelaxNG (jing)</title></head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <link title="indekso-stilo" type="text/css" rel="stylesheet" href="../stl/indeksoj.css"/>
  <body>
    <h1>Strukturaj neregulaĵoj trovitaj per RelaxNG (jing)</h1>
    <p>
      La struktura kontrolo per <a target="_new" href="../dtd/vokoxml.rnc">vokoxml.rnc</a>
      (RelaxNG) estas pli strikta ol la kontrolo per la 
      <a target="_new" href="../dtd/vokoxml.dtd">dokumenttipdifino</a> (DTD).
      La malsupraj trovaĵoj do striktasence ne estas eraroj. Sed la neregulaĵoj povas
      montri erarojn, ekz. mislokitajn tradukojn inter sencoj atribuitaj al la derivaĵo 
      anstataŭ al la senco. Aŭ ili povas konfuzi postajn redaktantojn, kiuj ne atendas 
      la informojn en nekutima loko.
   </p>
   <p>
     La kontrolo ankaŭ trovas markojn neregule formitajn, gramatikajn informojn malĝuste etikeditajn
     kiel vortospeco k.a.
   </p>
   <p>
     La RelaxNG-strukturo estas ankoraŭ iom eksperimenta kaj do diskutinda. Do eble ne 
     ĉiu malsupra trovita neregulaĵo meritas korekton. 
   </p>
EOH

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

print <<EOT;
  <p>
    Generita je $date
  </p>
  </body>
</html>
EOT

sub output_error {
  my ($file,$line,$col,$error) = @_;
  $file = m|/([^/]+)\.xml|;
  my $art = $1;
  print "<dt> <a target='precipa' href=\"../art/$art.html\">$art:$line:$col</a>:</dt>\n";
  print "<dd>$error</dd>\n";
}

