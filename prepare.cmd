:: Name:     resolve.cmd
:: Purpose:  Transforms Salamanca TEI files to be self-contained and use zenodo vocabulary for some metadata
:: Author:   wagner@rg.mpg.de
:: Revision: Sept 2020

:: see https://stackoverflow.com/a/57449284/4042645

@echo off
set JAVA_BIN="C:\Program Files (x86)\Common Files\Oracle\Java\javapath\java.exe"

%JAVA_BIN% -cp "./prepare/saxon9he.jar" net.sf.saxon.Transform -s:%1 -xsl:"./prepare/1_fix_urls.xsl" -o:"temp1.xml"
.\prepare\xmllint.exe --nowarning --xinclude --nsclean "temp1.xml" > "temp2.xml"
%JAVA_BIN% -cp "./prepare/saxon9he.jar" net.sf.saxon.Transform -s:"temp2.xml" -xsl:"./prepare/2_use_zenodo_vocab.xsl" -o:%2

:: --postvalid 
del "temp1.xml" "temp2.xml"
