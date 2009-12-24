#!/bin/bash
wget -O /tmp/index.html http://onlinevideochannel.blogspot.com/
/home/mythtv/bin/online_movies.pl > /tmp/movie_urls.txt
DATE=`date +"%D %R"`
cat /tmp/movie_urls.txt | awk -v DATE="$DATE" '
BEGIN { FS = ","; 
	print "<mythmenu name=\"ONLINE_MOVIES\">"; 
	print "\t<button>";
	print "\t<type>RSYNC</type>";
	printf ("\t<text><![CDATA[Synch %s]]></text>",DATE);
	print "\t<action><![CDATA[EXEC /home/mythtv/bin/online_movies.sh]]></action>";
	print "\t</button>";
};
{
  if( NF > 0 ) {
	print "\t<button>";
	print "\t<type>VIDEO_BROWSER</type>";
	printf ("\t<text><![CDATA[%d. %s]]></text>\n", NR, $1);
	printf ("\t<action><![CDATA[EXEC /usr/bin/mplayer -fs -zoom -really-quiet -user-agent NSPlayer -cache 16000 \"%s\"]]></action>\n",$2);
	print "\t</button>";
  }
};
END {
	print "</mythmenu>";
}
' > /home/mythtv/unofficial_plugins/online_movies/online_movies.xml
