<?xml version="1.0" encoding="UTF-8"?>
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->
<!-- File: xml-zadanie-4-svg.xslt -->
<!-- Authors: Konrad Jaworski, Tomasz Witczak -->
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  Output -->
    <xsl:output method="xml"
                indent="yes"
                media-type="image/svg" />

    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - Templates -->
    <xsl:param name="width" select="40" /><!-- width of bars -->
    <xsl:param name="space" select="10" /><!-- space between bars and items -->

    <xsl:variable name="max-y" select="100" />

    <xsl:template name="BookStore" match="/bookStore">

            <xsl:call-template name="Statistics" />

    </xsl:template>

        <xsl:template name="Statistics">
        <!--        <xsl:call-template name="OverallBookCount" /> -->
                <xsl:call-template name="BookCountsPerAuthor" />
        </xsl:template>
      <!--      <xsl:template name="OverallBookCount">
                    <xsl:value-of select="count(/bookStore/books/book)" />
            </xsl:template> -->
            <xsl:template name="BookCountsPerAuthor">
                <svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" >
                    <rect x="10" y="10" width="200"
                          height="200" fill="red" stroke="black"/>
                   <!-- <xsl:element name="bookCountsPerAuthor">
                        <xsl:for-each select="/bookStore/authors/author">
                            <xsl:sort select="lastName" />
                            <xsl:variable name="authorID" select="@authorID" />
                            <xsl:variable name="bookCount"
                                      select="count(/bookStore/books/book[@authorID = $authorID])" />
                            <xsl:element name="authorsBookCount">
                                <xsl:element name="author">
                                    <xsl:value-of select="concat(
                                        /bookStore/authors/author[@authorID = $authorID]/firstName, ' ',
                                        /bookStore/authors/author[@authorID = $authorID]/lastName)" />
                                </xsl:element>
                                <xsl:element name="bookCount">
                                    <xsl:value-of select="$bookCount" />
                                </xsl:element>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:element> -->
                </svg>
            </xsl:template>

</xsl:stylesheet>
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->