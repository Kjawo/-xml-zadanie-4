<?xml version="1.0" encoding="UTF-8"?>
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->
<!-- File: xml-zadanie-4-to-txt.xslt -->
<!-- Authors: Konrad Jaworski, Tomasz Witczak -->
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  Output -->
    <xsl:output method="xml" encoding="utf-8"/>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - Templates -->
    <xsl:template name="BookStore" match="/bookStore">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4"
                                       page-width="210mm" page-height="297mm"
                                       margin-top="1cm" margin-bottom="1cm"
                                       margin-left="1cm" margin-right="1cm">
                    <fo:region-body margin="1cm"/>
                    <fo:region-before extent="2cm"/>
                    <fo:region-after extent="2cm"/>
                    <fo:region-start extent="2cm"/>
                    <fo:region-end extent="2cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="A4">

                <fo:flow flow-name="xsl-region-body">

                    <fo:block border-width="1.5pt"
                              border-style="solid"
                              border-color="black"
                              background-color="white">
               <!--         <xsl:call-template name="ReportGenerationTime" /> -->
                        <xsl:apply-templates select="books" />
                        <xsl:call-template name="Statistics" />
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>

        </fo:root>
    </xsl:template>
    <!--    <xsl:template name="ReportGenerationTime">
            <fo:block>Report generation time:
                <xsl:value-of select="format-dateTime(current-dateTime(),
                                    '[H01]:[m01] [D01]-[M01]-[Y0001]')" />
            </fo:block>

        </xsl:template> -->
        <xsl:template name="Books" match="books">
            <xsl:apply-templates select="book">
                <xsl:sort select="title" />
            </xsl:apply-templates>
        </xsl:template>
            <xsl:template name="Book" match="book">
                    <xsl:apply-templates select="title" />
                    <xsl:apply-templates select="@authorID" />
                    <xsl:apply-templates select="@genreID" />
                    <xsl:apply-templates select="@publisherID" />
                    <xsl:apply-templates select="publishYear" />
                    <xsl:apply-templates select="@coverTypeID" />
                    <xsl:apply-templates select="pages" />
                    <xsl:apply-templates select="isbn" />
                    <xsl:apply-templates select="price" />
            </xsl:template>
                <xsl:template name="Author" match="@authorID">
                        <xsl:variable name="authorID" select="." />
                        <xsl:value-of select="concat(
                                    /bookStore/authors/author[@authorID = $authorID]/firstName, ' ',
                                    /bookStore/authors/author[@authorID = $authorID]/lastName)" />
                </xsl:template>
                <xsl:template name="Genre" match="@genreID">
                    <fo:block>
                        <xsl:variable name="genreID" select="." />
                        <xsl:value-of select="/bookStore/genres/genre[@genreID = $genreID]" />
                    </fo:block>
                </xsl:template>
                <xsl:template name="Publisher" match="@publisherID">
                    <fo:block>
                        <xsl:variable name="publisherID" select="." />
                        <xsl:value-of select="/bookStore/publishers/publisher[@publisherID = $publisherID]" />
                    </fo:block>
                </xsl:template>
                <xsl:template name="CoverType" match="@coverTypeID">
                    <fo:block>
                        <xsl:variable name="coverTypeID" select="." />
                        <xsl:value-of select="/bookStore/coverTypes/coverType[@coverTypeID = $coverTypeID]" />
                    </fo:block>
                </xsl:template>
                <xsl:template name="Title" match="title">
                    <fo:block>
                        <xsl:value-of select="." />
                    </fo:block>
                </xsl:template>
                <xsl:template name="Pages" match="pages">
                    <fo:block>
                        <xsl:value-of select="." />
                    </fo:block>
                </xsl:template>
                <xsl:template name="PublishYear" match="publishYear">
                    <fo:block>
                        <xsl:value-of select="." />
                    </fo:block>
                </xsl:template>
                <xsl:template name="Price" match="price">
                    <fo:block>
                        <xsl:value-of select="." />
                    </fo:block>
                </xsl:template>
                <xsl:template name="ISBN" match="isbn">
                    <fo:block>
                        <xsl:value-of select="." />
                    </fo:block>
                </xsl:template>
        <xsl:template name="Statistics">
            <fo:block><xsl:text>Liczba książek:                   </xsl:text><xsl:call-template name="OverallBookCount" /> <xsl:text>&#xa;</xsl:text></fo:block>
            <fo:block><xsl:text>Średnia liczba stron:             </xsl:text><xsl:call-template name="AveragePageCount" /> <xsl:text>&#xa;</xsl:text></fo:block>
            <fo:block> <xsl:text>Średnia cena:                     </xsl:text><xsl:call-template name="AveragePrice" /> <xsl:text>&#xa;</xsl:text></fo:block>
            <fo:block><xsl:text>Liczba gatunków:                  </xsl:text><xsl:call-template name="GenreCount" /> <xsl:text>&#xa;</xsl:text></fo:block>
            <fo:block><xsl:text>Liczba wydawców:                  </xsl:text><xsl:call-template name="PublisherCount" /> <xsl:text>&#xa;</xsl:text></fo:block>
            <fo:block><xsl:text>Najpopularniejszy rodzaj okładki: </xsl:text><xsl:call-template name="MostCommonCoverType" /> <xsl:text>&#xa;&#xa;</xsl:text></fo:block>
            <fo:block><xsl:text>Autor:              Liczba książek:&#xa;</xsl:text></fo:block>
            <xsl:call-template name="BookCountsPerAuthor" />
        </xsl:template>
            <xsl:template name="OverallBookCount">
                <fo:block>
                    <xsl:value-of select="count(/bookStore/books/book)" />
                </fo:block>
            </xsl:template>
            <xsl:template name="AveragePageCount">
                <fo:block>
         <!--           <xsl:value-of select="round(avg(/bookStore/books/book/pages))" /> -->
                </fo:block>
            </xsl:template>
            <xsl:template name="AveragePrice">
                <fo:block>
       <!--             <xsl:value-of select="format-number(avg(/bookStore/books/book/price), '#.##')" /> -->
                </fo:block>
            </xsl:template>
            <xsl:template name="GenreCount">
                <fo:block>
                    <xsl:value-of select="count(/bookStore/genres/genre)" />
                </fo:block>
            </xsl:template>
            <xsl:template name="PublisherCount">
                <fo:block>
                    <xsl:value-of select="count(/bookStore/publishers/publisher)" />
                </fo:block>
            </xsl:template>
            <xsl:template name="MostCommonCoverType">
                <fo:block>
                    <xsl:choose>
                        <xsl:when test="count(/bookStore/books/book[@coverTypeID='paperback']) >
                            xs:integer(round(count(/bookStore/books/book) div 2))">miękka</xsl:when>
                        <xsl:otherwise>twarda</xsl:otherwise>
                    </xsl:choose>
                </fo:block>
            </xsl:template>
            <xsl:template name="BookCountsPerAuthor">
                <fo:block>
                    <xsl:for-each select="/bookStore/authors/author">
                        <xsl:sort select="lastName" />
                        <xsl:variable name="authorID" select="@authorID" />
                        <xsl:variable name="bookCount"
                                  select="count(/bookStore/books/book[@authorID = $authorID])" />
                        <fo:block>
                            <xsl:element name="author">
                                <xsl:value-of select="concat(
                                    /bookStore/authors/author[@authorID = $authorID]/firstName, ' ',
                                    /bookStore/authors/author[@authorID = $authorID]/lastName)" />
                            </xsl:element>
                            <xsl:element name="bookCount">
                                <xsl:value-of select="$bookCount" />
                            </xsl:element>
                        </fo:block>
                    </xsl:for-each>
                </fo:block>
            </xsl:template>

</xsl:stylesheet>
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->