<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei xsl #default"
    version="2.0">

    <xsl:output method="xml"/>
<!--    <xsl:strip-space elements="p div head titlePart hi damage unclear"/>-->
    <xsl:strip-space elements="tei:choice tei:abbr tei:expan tei:orig tei:reg tei:sic tei:corr tei:g tei:damage tei:unclear"/>

    <!-- for the root node, insert xml scheme processing instructions -->
    <xsl:template match="/"><xsl:text>
</xsl:text>
        <xsl:processing-instruction name="xml-model">
            href="http://files.salamanca.school/saltei.rng"
            type="application/xml"
            schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction><xsl:text>
</xsl:text>
        <xsl:apply-templates select="*"/>
    </xsl:template>

    <!-- IdentityTransform -->
    <xsl:template match="@xml:base" />
    <xsl:template match="@href">
        <xsl:attribute name="href">
            <xsl:value-of select="replace(., '(https://files.salamanca.school/)|(../meta/)', 'http://files.salamanca.school/')"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template mode="#all" match="@* | node()">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@* | node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>

    <!-- Another identity transform to get rid of redundant tei: namespaces/prefixes -->
<!--
    <xsl:template mode="#all" match="tei:*">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="@* | node()" mode="#current"/>
        </xsl:element>
    </xsl:template>
-->

    <!-- Use zenodo vocabulary for contributor roles (#scholarly, #technical, #additional) -->
    <xsl:template match="/TEI/teiHeader/fileDesc/titleStmt/editor/@role">
        <xsl:choose>
            <xsl:when test=". = '#scholarly'">
                <xsl:attribute name="role">Editor</xsl:attribute>
            </xsl:when>
            <xsl:when test=". = '#technical'">
                <xsl:attribute name="role">DataManager</xsl:attribute>
            </xsl:when>
            <xsl:when test=". ='#additional'">
                <xsl:attribute name="role">Other</xsl:attribute>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- Use zenodo vocabulary for contributor roles (for project leaders) -->
    <xsl:template match="/TEI/teiHeader/fileDesc/seriesStmt/editor">
        <xsl:element name="editor">
            <xsl:if test="@xml:id = ('TD', 'MLB')">
                <xsl:attribute name="role">ProjectLeader</xsl:attribute>
                <xsl:apply-templates select="@* | node()"/>
            </xsl:if>
        </xsl:element>
    </xsl:template>

    <!-- Use zenodo vocabulary for licence types -->
    <xsl:template match="//publicationStmt/availability/licence"> <!-- n="cc-by" -->
        <xsl:element name="licence">
            <xsl:attribute name="n">cc-by</xsl:attribute>
            <xsl:apply-templates select="@* | node()" mode="#current"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
