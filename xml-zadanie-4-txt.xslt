<?xml version="1.0" encoding="UTF-8"?>
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->
<!-- File: xml-zadanie-4-txt.xslt -->
<!-- Authors: Konrad Jaworski, Tomasz Witczak -->
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  Output -->
    <xsl:output method="text" version="1.0" encoding="UTF-8" />

    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - Templates -->
    <xsl:template name="BookStore" match="/bookStore">
            <xsl:call-template name="ReportGenerationTime" />

            <xsl:text>Spis Książek:&#xa;</xsl:text>
            <xsl:text>============================================================================================================&#xa;</xsl:text>
            <xsl:text>Tytuł:                   Autor:              Gatunek:  Wydawca:        Rok:  Strony: ISBN:&#xa;&#xa;</xsl:text>
            <xsl:apply-templates select="books" />

            <xsl:text>============================================================================================================&#xa;&#xa;</xsl:text>

            <xsl:text>=========================================&#xa;</xsl:text>
            <xsl:text>Statystyki:&#xa;&#xa;</xsl:text>
            <xsl:call-template name="Statistics" />
            <xsl:text>&#xa;=========================================&#xa;</xsl:text>
    </xsl:template>
        <xsl:template name="ReportGenerationTime">
            <xsl:text>=======================&#xa;</xsl:text>
            <xsl:text>Report generation time:&#xa;</xsl:text>
            <xsl:value-of select="format-dateTime(current-dateTime(),
                                '[H01]:[m01] [D01]-[M01]-[Y0001]')" />
            <xsl:text>&#xa;=======================&#xa;&#xa;</xsl:text>

        </xsl:template>
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
                    <!-- <xsl:apply-templates select="@coverTypeID" /> -->
                    <xsl:apply-templates select="pages" />
                    <xsl:apply-templates select="isbn" />
                    <xsl:apply-templates select="price" />
                    <xsl:text>&#xa;</xsl:text>
            </xsl:template>
                <xsl:template name="Author" match="@authorID">
                        <xsl:variable name="authorID" select="." />
                        <xsl:value-of select="substring( concat( concat(
                                    /bookStore/authors/author[@authorID = $authorID]/firstName, ' ',
                                    /bookStore/authors/author[@authorID = $authorID]/lastName), '                                 ' ),1,20 )" />
                </xsl:template>
                <xsl:template name="Genre" match="@genreID">
                    <xsl:element name="genre">
                        <xsl:variable name="genreID" select="." />
                        <xsl:value-of select="substring(concat(/bookStore/genres/genre[@genreID = $genreID], '                     '),1,10)" />
                    </xsl:element>
                </xsl:template>
                <xsl:template name="Publisher" match="@publisherID">
                    <xsl:element name="publisher">
                        <xsl:variable name="publisherID" select="." />
                        <xsl:value-of select="substring(concat(/bookStore/publishers/publisher[@publisherID = $publisherID], '                    '),1,16)" />
                    </xsl:element>
                </xsl:template>
           <!--     <xsl:template name="CoverType" match="@coverTypeID">
                    <xsl:element name="coverType">
                        <xsl:variable name="coverTypeID" select="." />
                        <xsl:value-of select="/bookStore/coverTypes/coverType[@coverTypeID = $coverTypeID]" />
                    </xsl:element>
                </xsl:template> -->
                <xsl:template name="Title" match="title">
                    <xsl:element name="title">
                        <xsl:value-of select="substring(concat(., '                                   '),1,25)" />
                    </xsl:element>
                </xsl:template>
                <xsl:template name="Pages" match="pages">
                    <xsl:element name="pages">
                        <xsl:value-of select="substring(concat(., '             '),1,8)" />
                    </xsl:element>
                </xsl:template>
                <xsl:template name="PublishYear" match="publishYear">
                    <xsl:element name="publishYear">
                        <xsl:value-of select="substring(concat(., '           '),1,6)" />
                    </xsl:element>
                </xsl:template>
                <xsl:template name="Price" match="price">
                    <xsl:element name="price">
                        <xsl:value-of select="." />
                    </xsl:element>
                </xsl:template>
                <xsl:template name="ISBN" match="isbn">
                    <xsl:element name="isbn">
                        <xsl:value-of select="." />
                    </xsl:element>
                </xsl:template>
        <xsl:template name="Statistics">
                <xsl:text>Liczba książek:                   </xsl:text><xsl:call-template name="OverallBookCount" /> <xsl:text>&#xa;</xsl:text>
                <xsl:text>Średnia liczba stron:             </xsl:text><xsl:call-template name="AveragePageCount" /> <xsl:text>&#xa;</xsl:text>
                <xsl:text>Średnia cena:                     </xsl:text><xsl:call-template name="AveragePrice" /> <xsl:text>&#xa;</xsl:text>
                <xsl:text>Liczba gatunków:                  </xsl:text><xsl:call-template name="GenreCount" /> <xsl:text>&#xa;</xsl:text>
                <xsl:text>Liczba wydawców:                  </xsl:text><xsl:call-template name="PublisherCount" /> <xsl:text>&#xa;</xsl:text>
                <xsl:text>Najpopularniejszy rodzaj okładki: </xsl:text><xsl:call-template name="MostCommonCoverType" /> <xsl:text>&#xa;&#xa;</xsl:text>
                <xsl:text>Autor:              Liczba książek:&#xa;</xsl:text>
                <xsl:call-template name="BookCountsPerAuthor" />
        </xsl:template>
            <xsl:template name="OverallBookCount">
                <xsl:element name="overallBookCount">
                    <xsl:value-of select="count(/bookStore/books/book)" />
                </xsl:element>
            </xsl:template>
            <xsl:template name="AveragePageCount">
                <xsl:element name="averagePageCount">
                    <xsl:value-of select="round(avg(/bookStore/books/book/pages))" />
                </xsl:element>
            </xsl:template>
            <xsl:template name="AveragePrice">
                <xsl:element name="averagePrice">
                    <xsl:value-of select="format-number(avg(/bookStore/books/book/price), '#.##')" />
                </xsl:element>
            </xsl:template>
            <xsl:template name="GenreCount">
                <xsl:element name="genreCount">
                    <xsl:value-of select="count(/bookStore/genres/genre)" />
                </xsl:element>
            </xsl:template>
            <xsl:template name="PublisherCount">
                <xsl:element name="publisherCount">
                    <xsl:value-of select="count(/bookStore/publishers/publisher)" />
                </xsl:element>
            </xsl:template>
            <xsl:template name="MostCommonCoverType">
                <xsl:element name="mostCommonCoverType">
                    <xsl:choose>
                        <xsl:when test="count(/bookStore/books/book[@coverTypeID='paperback']) >
                            xs:integer(round(count(/bookStore/books/book) div 2))">miękka</xsl:when>
                        <xsl:otherwise>twarda</xsl:otherwise>
                    </xsl:choose>
                </xsl:element>
            </xsl:template>
            <xsl:template name="BookCountsPerAuthor">
                <xsl:element name="bookCountsPerAuthor">
                    <xsl:for-each select="/bookStore/authors/author">
                        <xsl:sort select="lastName" />
                        <xsl:variable name="authorID" select="@authorID" />
                        <xsl:variable name="bookCount"
                                  select="count(/bookStore/books/book[@authorID = $authorID])" />
                        <xsl:element name="authorsBookCount">
                            <xsl:element name="author">
                                <xsl:value-of select="substring( concat( concat(
                                    /bookStore/authors/author[@authorID = $authorID]/firstName, ' ',
                                    /bookStore/authors/author[@authorID = $authorID]/lastName), '                                 ' ),1,20 )" />
                            </xsl:element>
                            <xsl:element name="bookCount">
                                <xsl:value-of select="$bookCount" /><xsl:text>&#xa;</xsl:text>
                            </xsl:element>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:template>

</xsl:stylesheet>
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->