
#=================================================================
# OpenMind 0.2 [Beyond] > 15.10.2012
# OpenMind Desarollado por rithchard usando Software Libre
# OpenMind > Wikipedia OffLine > Basado en Wikipedia
#
# Quieres implementar OpenMind en tu Colegio o Institución
# Por favor contactame a:
# rithchard@gmail.com ó facebook.com/rithchard
#=================================================================

#use warnings;
#use strict;
use File::Slurp;
use LWP::UserAgent;
use List::MoreUtils qw(uniq);

$ua = LWP::UserAgent->new();
$receptor = "http://localhost/OpenMind/receptor.php"; # <=======
$true = '47f5tDF4f5ssRY4';
$OpenMindArtFolder = 'OpenMindArt001';
$OpenMindImgFolder = 'OpenMindImg001';
$ckecka = 0;$bajar = 0;
$n = 0;
$limit = 1000;
####### HEAD ##########
# print ">>>[ $ncont genWords encontrados ]\n";
###### MAIN ######
if ($ARGV[0] eq '--add' && $ARGV[1]){
	my @spl = split(/,/,$ARGV[1]);
	$n = 1;
	foreach $toAdd (@spl){
	print ">>>VUELTA >>$n\n";
	getArticulo();
	$n = $n +1;
	}
}elsif($ARGV[0] eq '--boot' && $ARGV[1]){
print "$ARGV[1]";
getBoot($ARGV[1]);

}elsif($ARGV[0] eq '--update' && $ARGV[1]){
	my @spl = split(/,/,$ARGV[1]);
	foreach $toAdd (@spl){
	getArticulo($toAdd);
	}
}elsif($ARGV[0] eq '--remove' && $ARGV[1]){
#removeArt($ARGV[1]);
	my @spl = split(/,/,$ARGV[1]);
	foreach $toAdd (@spl){
	removeArt($toAdd);
	}
}elsif($ARGV[0] eq '--massive' && $ARGV[1]){
if (!-e $ARGV[1]){
	print qq {
	El archivo $ARGV[1] no existe
	=============================================================
	Usa asi:	OpenMind.pl --massive words.txt
	};usage();exit;
}
$ncont = 0;
open FICHERO, $ARGV[1];
open CONTAR, $ARGV[1];
while($get = <CONTAR>){chop($get);$ncont = $ncont +1;}close CONTAR;
print ">>>[ $ncont genWords encontrados ]\n";
while($get = <FICHERO>){chop($get);
	getArticulo($get);
}close FICHERO;
print ">>>[ $ncont genWords encontrados ]\n";
}elsif($ARGV[0] eq '--help'){
usage();
}else{
main();
}
###### END MAIN ######

###### RUTINAS ######
sub removeArt{
checkServer();
$get = $_[0];$get =~ s/ /_/;
my $query = $receptor."?start=22ddeb2b02adc1908cc055570f1b16d5&gartn="."$get";
my $resp = $ua->get($query);my $content = $resp->content;
if ($content =~ /$true/){
	print ">>>[ Procediendo a remover '$get' ]\n";
	my $query = $receptor."?start=22ddeb2b02adc1908cc055570f1b16d5&removeArt="."$get";
	my $resp = $ua->get($query);
	print ">>>[ '$get' Fue eliminado con exito]\n";
}else{
print ">>>[ No existe el Articulo ] => $get\n";
}
}

sub main{
	print qq {
	===========================================================
	OpenMind 0.2 [Beyond] > 15.10.2012
	OpenMind Desarollado por rithchard usando Software Libre
	OpenMind > Wikipedia OffLine > Basado en Wikipedia
	
	Quieres implementar OpenMind en tu Colegio o Institución
	Por favor contactame a:
	rithchard\@gmail.com ó facebook.com/rithchard
	===========================================================
	
	¿No sabes como funciona?
	Escribe OpenMind.pl --help
	\n};
}
sub usage{
	print qq {
	Modo de uso de OpenMind.pl
	·····························································
	OpenMind.pl [ Opción ] [ Nombre del Articulo ]
	
	OpenMind.pl --add Bolivia
	OpenMind.pl --boot Bolivia
	OpenMind.pl --update Bolivia
	OpenMind.pl --remove Bolivia
	OpenMind.pl --massive words.txt
	
	Opciones:
	·····························································
	--add  		Agrega un articulo a OpenMind
	--boot 		Modo roboot
	--update  	Actualiza un articulo en OpenMind
	--remove 	Elimina un articulo de OpenMind
	--massive 	Agrega articulos desde una lista de palabras
	\n};
}

sub sacames {
@meses =('ene','feb','mar','abr','may','jun','jul','ago','sep','oct','nov','dic');
if ($meses[0] eq $_[0]){
$mes = 1;
}elsif ($meses[1] eq $_[0]){
$mes = 2;
}elsif ($meses[2] eq $_[0]){
$mes = 3;
}elsif ($meses[3] eq $_[0]){
$mes = 4;
}elsif ($meses[4] eq $_[0]){
$mes = 5;
}elsif ($meses[5] eq $_[0]){
$mes = 6;
}elsif ($meses[6] eq $_[0]){
$mes = 7;
}elsif ($meses[7] eq $_[0]){
$mes = 8;
}elsif ($meses[8] eq $_[0]){
$mes = 9;
}elsif ($meses[9] eq $_[0]){
$mes = 10;
}elsif ($meses[10] eq $_[0]){
$mes = 11;
}elsif ($meses[11] eq $_[0]){
$mes = 12;
}
}
sub sacatitulo {
$_[0] =~ m/class="firstHeading">(.+)<\/h1>/;
$get = $1;
}
sub limpiar {
$_[0] =~ s/%C3%A1/a/gsm;$_[0] =~ s/%c3%a1/a/gsm;
$_[0] =~ s/%C3%A9/e/gsm;$_[0] =~ s/%c3%a9/e/gsm;
$_[0] =~ s/%C3%AD/i/gsm;$_[0] =~ s/%c3%ad/i/gsm;
$_[0] =~ s/%C3%B3/o/gsm;$_[0] =~ s/%c3%b3/o/gsm;
$_[0] =~ s/%C3%BA/u/gsm;$_[0] =~ s/%c3%ba/u/gsm;

$_[0] =~ s/%C3%81/A/gsm;$_[0] =~ s/%c3%81/A/gsm;
$_[0] =~ s/%C3%89/E/gsm;$_[0] =~ s/%c3%89/E/gsm;
$_[0] =~ s/%C3%8D/I/gsm;$_[0] =~ s/%c3%8d/I/gsm;
$_[0] =~ s/%C3%93/O/gsm;$_[0] =~ s/%c3%93/O/gsm;
$_[0] =~ s/%C3%9A/U/gsm;$_[0] =~ s/%c3%9a/U/gsm;

$_[0] =~ s/%C3%B1/ñ/gsm;$_[0] =~ s/%c3%b1/ñ/gsm;
$_[0] =~ s/%C3%91/ñ/gsm;$_[0] =~ s/%c3%91/ñ/gsm;
return $_[0];
}
sub renLink {
$_[0] =~ s/\?%A1/á/gsm;
$_[0] =~ s/\?%A9/é/gsm;
$_[0] =~ s/\?%AD/í/gsm;
$_[0] =~ s/\?%B3/ó/gsm;
$_[0] =~ s/\?%BA/ú/gsm;

$_[0] =~ s/\?%81/Á/gsm;
$_[0] =~ s/\?%89/É/gsm;
$_[0] =~ s/\?%8D/Í/gsm;
$_[0] =~ s/\?%93/Ó/gsm;
$_[0] =~ s/\?%9A/Ú/gsm;

$_[0] =~ s/\?%B1/ñ/gsm;
$_[0] =~ s/\?%91/Ñ/gsm;
return $_[0];
}
sub removeRepetidos{
	foreach my $parte ( @_ ){
		next if $ya_visto{ $parte }++;
			push @revisado, $parte."";
	}
return @revisado;
}
sub getArticulo{
if (!$get){$get = $toAdd;}
#print ">>>> '$get'\n";exit;
if ($get !~ "desambiguacion" && $get !~ ".jpeg" && $get !~ ".png" && $get !~ ".jpg" && $get !~ ".gif" && $get !~ "archivo:" && $get !~ ".svg" && $get !~ ":" && $get !~ "Especial:"){
print ">>>[ El articulo esta limpio] => $get\n";
########## add article to OpenMind ############
print ">>>[ Bajando Articulo checking...] => $get\n";
$bajar = 0;
$ckecka = 0;
$conthtml = 0;
$getwiki = $get;$get = "\L$get";
$get =~ s/ /_/;$getwiki =~ s/ /_/;
$get = &limpiar($get);$getwiki = &limpiar($getwiki);

my $query = $receptor."?start=22ddeb2b02adc1908cc055570f1b16d5&gartn="."$get";
print ">>>[ Checking si Articulo existe en OpenMind ] => $hserver\n";
my $resp = $ua->get($query);my $content = $resp->content;

if ($content =~ /$true/){
print ">>>[ Existe pero chekar para actualizar ] => $get\n";
$ckecka = 1;
}else{
print ">>>[ Preparandose para bajar Articulo ] => http://es.wikipedia.org/wiki/$get\n";
$bajar = 1;
}
system ("wget -c http://es.wikipedia.org/wiki/$getwiki");
if ($ckecka == 1){ ### Actualizamos
my @fpubli;
##### GET CHECK AYEAR MES ########
my $gtrue = '47f5tDF4f5ssRY4';
my $query = $receptor."?start=22ddeb2b02adc1908cc055570f1b16d5&gartn=".$get;
my $resp = $ua->get($query);my $content = $resp->content;
my @chekes = $content =~ /\[(.*?)\]/g;
########################
print ">>>[ Checkando para ver si actualizamos o no! ] => $get\n";
### CHECK DATES ####
my $content = read_file("$getwiki");
$adb = $chekes['1']; # <<
$mdb = $chekes['0']; # << 8
print $adb." ".$mdb;

my @fpubli = $content =~ /vez el (.*?), a las/;
$fpubli=pop(@fpubli);
@dpubli = split(/ /,$fpubli);
$aact = $dpubli[2]; # >> year act
$mact = $dpubli[1]; # >> 2 mes
print "\n>>>[ Actual: $mact => $aact ] => $get\n";
print ">>>[ ArtiDB: $mdb => $adb ] => $get\n\n";
my $mdb = &sacames($mdb);
my $mact = &sacames($mact);

if ($aact == $adb){
print ">>>[ Articulos anios iguales ] => $get\n";
	if ($mact > $mdb){
	$bajar = 1;
	print ">>>[ Bajamos articulo, es mas actual por meses ] => $get\n";
	}else{
	print ">>>[ No Actualizar ] => $get\n";
	system ("rm $getwiki");
	}
}else{
print ">>>[ Articulos anios distintos ] => $get\n";
	if ($aact > $adb){
	print ">>>[ Bajamos articulo, es mas actual por anio ] => $get\n";
	$bajar = 1;
	}else{
	print ">>>[ No Actualizar ] => $get\n";
	system ("rm $getwiki");
	}
}
### CHECK DATES ####
}
if ($bajar == 1){ # Bajamos articulo
print ">>>[ Procediendoo a Bajar ] => $get\n";
open (ESCTMP,"$getwiki");
my @registros=<ESCTMP>;
my @extyes;
$test = 0;
foreach $reg (@registros){
if ($test==1){
push (@extyes,$reg);
}
#if ($reg =~ m/<!-- content -->/){
if ($reg =~ m/\<div id\=\"mw\-head\-base\" class\=\"noprint\"\>\<\/div\>/){
$test = 1;
}
#last if ($reg =~ m/<!-- \/content -->/);
last if ($reg =~ m/\<div id\=\"mw\-navigation\"\>/);
}
close (ESCTMP);
my $conthtml = join "", @extyes;
#my @imgwget = $conthtml =~ /<img.*? src="\Khttp:[^"](.+?")/g; # add to array img's Wget
$conthtml =~ s/%2C/,/gsm; # reemplazamos %2C por ,
my @imgwget = $conthtml =~ /<img.*? src="[^"](.+?")/g; # add to array img's Wget
$conthtml = &limpiar($conthtml);
while ($conthtml =~ s/<img [^>]+? \K \@28/(/gix) { 1 }; # reemplazamos los % por @
while ($conthtml =~ s/<img [^>]+? \K \@29/)/gix) { 1 }; # reemplazamos los % por @
$conthtml =~ s{<img.*? src="\K\/\/[^"]+/(.+?")}{$OpenMindImgFolder/$1}gsm; # reemplazamos <img src=blabla
#$conthtml =~ s{%}{@}gsm; # reemplazamos % por @
$conthtml =~ s{<a.*? href="\K\/wiki\/+(.+?")}{index.php?title=$1}gsm; # reemplazamos acceso a articulos # u indice de contenidos #
#$conthtml =~ s{<a.*? href="\K\/w\/+(.+?")}{$1}gsm; # reemplazamos acceso a articulos # u indice de contenidos #
#$conthtml =~ s/<span class="editsection">(.+?)<\/span>//gsm; # reemplazamos [edit] deletes // version anterior deprecated
$conthtml =~ s/\<span class\=\"mw\-editsection\"\>(.+?)\<\/span>\<\/span>//gsm; # reemplazamos [edit] deletes
$conthtml =~ s/<!-- sitenotice -->/<a href="http:\/\/www.facebook.com\/rithchard" class="powered" title="Creado por rithchard">Powered by <strong>OpenMind<\/strong> Inc.<\/a><!-- sitenotice -->/gsm; # Add Powered by rithchard ;)
$conthtml =~ s/<!-- catlinks -->(.+?)<!-- \/catlinks -->//gsm; # reemplazamos [categorias] en footer
$conthtml =~ s/<!-- sitenotice -->(.+?)<!-- \/sitenotice -->//gsm; # reemplazamos publicdd :D
#$conthtml =~ s/<!-- subtitle -->(.+?)<!-- \/subtitle -->/<div id="contentSub"><\/div>/gsm; # reemplazamos reeedirid de
$conthtml =~ s/<div class="rellink noprint">(.+?)\(desambiguación\)<\/a>.<\/div>//gsm; # reemplazamos desambiguacio
$conthtml =~ s/<table style="" class="noprint plainlinks ambox ambox-style">(.+?)<\/table>//gsm; # reemplazamos error de autor 
# <a href="/wiki/Archivo:Glider.svg" class="internal" title="Aumentar">
# <a href="index.php?title=Archivo:Coat_of_arms_of_Bolivia.svg" class="image">
########## Metemos artn to DB #####
###################################
$get = limpiar($get);
if (-e $getwiki){
$get =~ s/ /_/;
my $content = read_file("$getwiki");
###################################
my @fpubli = $content =~ /vez el (.*?), a las/;
$fpubli=pop(@fpubli);
@dpubli = split(/ /,$fpubli);
print ">>>[ Enviando articulo a OpenMind ... ] => $get\n";
checkServer();
my $query = $receptor."?newadd=OpenMind&start=22ddeb2b02adc1908cc055570f1b16d5&artn=".$get."&d=".$dpubli[0]."&m=".$dpubli[1]."&a=".$dpubli[2]."&ArtFolder=".$OpenMindArtFolder;
my $resp = $ua->get($query);my $content = $resp->content;
print ">>>[ Articulo enviado a OpenMind con exito! ] => $get\n";
########## Metemos artn to DB #####
open (ESCRIBIR,">$OpenMindArtFolder\/\/$get.bo");
print ESCRIBIR "		<!-- content -->\n";
print ESCRIBIR $conthtml;
close (ESCRIBIR);
#system ("del /f /q $get");
foreach $i (@imgwget){ # download img's
#$i = $i =~ /px[^"](.+?")/g;$i = $1;$i =~ s/"//g;$i =~ s/_/ /g;
system ("wget -P $OpenMindImgFolder -c \"http:/$i");
if ($i =~ "%C3%A1" || $i =~ "%C3%A9" || $i =~ "%C3%AD" || $i =~ "%C3%B3" || $i =~ "%C3%BA" || $i =~ "%C3%81" || $i =~ "%C3%89" || $i =~ "%C3%8D" || $i =~ "%C3%93" || $i =~ "%C3%9A" || $i =~ "%C3%B1" || $i =~ "%C3%91"){
print ">>>[ IMG sometido a utf8 ] => $i\n";
$i =~ m{^(.*)\/(.*)"$}x;$imgruta = $2;$imgruta =~ s/%C3/?/gsm;
$new = &limpiar($i);
$new =~ m{^(.*)\/(.*)"$}x;$new = $2;
print "$imgruta => $new\n";
system("mv $OpenMindImgFolder\/$imgruta $OpenMindImgFolder\/$new");
$imgruta = &renLink($imgruta);
print "$imgruta => $new\n";
system("mv $OpenMindImgFolder\/$imgruta $OpenMindImgFolder\/$new");
}
}
foreach $ruta (@imgwget){ #here send img name's for db img gallery
$ruta =~ m{^(.*)\/(.*)"$}x;$imgruta = $2;
$ruta =~ m{^(.*)px-(.*)"$}x;$name = $2;$name =~ s/.svg//g;$name =~ s/.SVG//g;
$name =~ s/_/ /g;if($name =~ m/(\w+)$/){$name =~ s/.$1//g;}
print ">>>[ Img to server ] => $imgruta => $name\n";
#checkServer();
my $query = $receptor."?start=22ddeb2b02adc1908cc055570f1b16d5&imgruta=".$imgruta."&nameart=".$get."&name=".$name."&ImgFolder=".$OpenMindImgFolder;
my $resp = $ua->get($query);my $content = $resp->content;
}
}else{
print ">>>[ Error al descargar articulo ] => $get\n";
system ("rm $getwiki");
}
}else{
print ">>>[ Fatal error ] => $get\n"; # Codigo 886: Me fui xD
}
print "\n";
########## add article to OpenMind ############
}else{
print ">>>[ Imposible, no puedo bajar eso ] => http://es.wikipedia.org/wiki/$get\n";
print "===========================================================\n";
}
system("rm $getwiki");
}
sub getBoot{
checkServer(); # Verificamos si SERVER_recetor sta vivo
$genword = $_[0];$genword =~ s/ /_/;$toAdd = $genword;
getArticulo();
# STARTING BAJAR ARTICULO
while ($n <= $limit){
print " |************************|\n |        $genword        |\n |************************|\n";
system ("wget -c http://es.wikipedia.org/wiki/$genword");
$genword = limpiar($genword);
if (-e $genword){
print ">>>[ Bajo el articulo ] => $genword\n";
open (GENWORD,"$genword");
my @registros=<GENWORD>;
my @extyes;
foreach $reg (@registros){
if ($test==1){
push (@extyes,$reg);
}
if ($reg =~ m/<!-- content -->/){
$test = 1;
}
last if ($reg =~ m/<!-- \/bodytext -->/);
}
my $html = join "", @extyes;
$html = limpiar($html);
my @htmlget = $html =~ /<a.*? href="\K\/wiki\/+(.+?)" /g; # add to array internal url's
my @htmlget = uniq(@htmlget); #remove array repetidos
#foreach $get (@htmlget){print "$get\n";}
foreach $get (@htmlget){
getArticulo();
system ("rm $get");
}
$genword = $htmlget[getRandom()];
my @spl = split(/:/,$genword);
$genword = $spl[0];
}else{
my @htmlget =('Bolivia','Oruro','Calama','Tarija','Cochabamba','Potosi','Pando','Sucre','Beni','Yacuiba');
$genword = $htmlget[getRandom()];
system ("rm $genword");
print ">>>[ No baje el articulo ] => $get\n"; 
}
$n++;
system ("rm $genword");
}
}


sub getRandom{
$time = time();
@hola = split("",$time);
return $getrandom = pop(@hola);
}
sub checkServer{
my $query = $receptor."?check";
print ">>>[ Checking si receptor sta vivo ] => $receptor\n";
my $resp = $ua->get($query);my $content = $resp->content;
if ($content !~ /$true/){
print ">>>[ Verifica el receptor ] => $receptor\n";
exit;
}else{
print ">>>[ OK.. ] => $receptor\n";
}
}
