<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei xsl #default"
    version="2.0">

    <xsl:output method="xml"/>

    <xsl:template match="/">
        <xsl:apply-templates select="*"/>
    </xsl:template>

    <xsl:template match="@href">
        <xsl:attribute name="href">
            <xsl:value-of select="replace(., '(http://files.salamanca.school/)|(../meta/)', 'https://files.salamanca.school/')"/>
        </xsl:attribute>
    </xsl:template>

    <!-- IdentityTransform -->
    <xsl:template mode="#all" match="@* | node()">
        <xsl:copy copy-namespaces="yes">
            <xsl:apply-templates select="@* | node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
