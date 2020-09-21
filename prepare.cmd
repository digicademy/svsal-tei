:: Name:     resolve.cmd
:: Purpose:  Transforms Salamanca TEI files to be self-contained and use zenodo vocabulary for some metadata
:: Author:   wagner@rg.mpg.de
:: Revision: Sept 2020

:: Xmllint/xmltproc seem to be among the VERY few tools able to resolve our XIncludes (since they make use of
:: the xpointer scheme in the xpointer attribute) besides eXist-db and our online web application.
:: See https://www.zlatkovic.com/projects/libxml/index.html for download links and more information.
::
:: For more conventional XSLT processing, we're using Saxon Home Edition.
::
:: We include all the necessary files here for convenience.

@echo off
set JAVA_BIN="C:\Program Files (x86)\Common Files\Oracle\Java\javapath\java.exe"

%JAVA_BIN% -cp "./prepare/saxon9he.jar" net.sf.saxon.Transform -s:%1 -xsl:"./prepare/1_fix_urls.xsl" -o:"temp1.xml"
.\prepare\xmllint.exe --nowarning --xinclude --nsclean "temp1.xml" > "temp2.xml"
%JAVA_BIN% -cp "./prepare/saxon9he.jar" net.sf.saxon.Transform -s:"temp2.xml" -xsl:"./prepare/2_use_zenodo_vocab.xsl" -o:%2

del "temp1.xml" "temp2.xml"