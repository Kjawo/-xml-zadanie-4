<?xml version="1.0" encoding="UTF-8"?>
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->
<!-- File: xml-zadanie-4-txt.xslt -->
<!-- Authors: Konrad Jaworski, Tomasz Witczak -->
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:functions="xml-zadanie-4-functions">
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  Output -->
    <xsl:output method="text" version="1.0" encoding="UTF-8" />

    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - Templates -->
    <xsl:template name="ClientReport" match="/clientReport">
        <xsl:value-of select="concat(functions:drawLineWithTitle($lineCharacter1, $lineLength,
                             ' [RAPORT] ', 'center'), '&#xa;')" />
        <xsl:value-of select="concat(functions:drawLineWithTitle($lineCharacter3, $lineLength,
                             '[Czas i data wygenerowania raportu] ', 'left'), '&#xa;')" />
        <xsl:apply-templates select="reportInformation" />
        <xsl:value-of select="'&#xa;&#xa;'" />
        <xsl:value-of select="concat(functions:drawLineWithTitle($lineCharacter1, $lineLength,
                             ' [Spis książek] ', 'center'), '&#xa;')" />
        <xsl:value-of select="concat(functions:drawLine($lineCharacter3, $lineLength), '&#xa;')" />
        <xsl:value-of select="concat(
            functions:drawLineWithTitle($lineCharacter2, $lineLengthTitle, '(Tytuł)', 'right'),
            functions:drawLineWithTitle($lineCharacter2, $lineLengthAuthor, '(Autor)', 'right'),
            functions:drawLineWithTitle($lineCharacter2, $lineLengthGenre, '(Gatunek)', 'right'),
            functions:drawLineWithTitle($lineCharacter2, $lineLengthPublisher, '(Wydawca)', 'right'),
            functions:drawLineWithTitle($lineCharacter2, $lineLengthPublishYear, '(Rok wydania)', 'right'),
            functions:drawLineWithTitle($lineCharacter2, $lineLengthCoverType, '(Rodzaj okładki)', 'right'),
            functions:drawLineWithTitle($lineCharacter2, $lineLengthPages, '(Liczba stron)', 'right'),
            functions:drawLineWithTitle($lineCharacter2, $lineLengthISBN, '(ISBN)', 'right'),
            functions:drawLineWithTitle($lineCharacter2, $lineLengthPrice, '(Cena [zł])', 'right'),
            '&#xa;')" />
        <xsl:value-of select="concat(functions:drawLine($lineCharacter3, $lineLength), '&#xa;')" />
        <xsl:apply-templates select="book" />
        <xsl:value-of select="'&#xa;'" />
        <xsl:value-of select="concat(functions:drawLineWithTitle($lineCharacter1, $lineLength,
                             ' [Statystyki] ', 'center'), '&#xa;')" />
        <xsl:apply-templates select="statistics" />
        <xsl:value-of select="concat(functions:drawLine($lineCharacter1, $lineLength), '&#xa;')" />
    </xsl:template>
        <xsl:template name="ReportInformation" match="reportInformation">
            <xsl:value-of select="concat('&gt; ', reportGenerationTime)" />
        </xsl:template>
        <xsl:template name="Book" match="book">
            <xsl:value-of select="concat(
                functions:drawLineWithTitle($lineCharacter2, $lineLengthTitle, title, 'right'),
                functions:drawLineWithTitle($lineCharacter2, $lineLengthAuthor, author, 'right'),
                functions:drawLineWithTitle($lineCharacter2, $lineLengthGenre, genre, 'right'),
                functions:drawLineWithTitle($lineCharacter2, $lineLengthPublisher, publisher, 'right'),
                functions:drawLineWithTitle($lineCharacter2, $lineLengthPublishYear, publishYear, 'right'),
                functions:drawLineWithTitle($lineCharacter2, $lineLengthCoverType, coverType, 'right'),
                functions:drawLineWithTitle($lineCharacter2, $lineLengthPages, pages, 'right'),
                functions:drawLineWithTitle($lineCharacter2, $lineLengthISBN, isbn, 'right'),
                functions:drawLineWithTitle($lineCharacter2, $lineLengthPrice, price, 'right'),
                '&#xa;')" />
        </xsl:template>
        <xsl:template name="Statistics" match="statistics">
            <xsl:value-of select="concat(functions:drawLineWithTitle($lineCharacter3, $lineLength,
                             ' [Ogólne]', 'right'), '&#xa;')" />
            <xsl:value-of select="concat(functions:statisticsItem($lineCharacter2, $lineLength,
                'Łączna liczba książek', overallBookCount), '&#xa;')" />
            <xsl:value-of select="concat(functions:statisticsItem($lineCharacter2, $lineLength,
                'Średnia liczba stron', averagePageCount), '&#xa;')" />
            <xsl:value-of select="concat(functions:statisticsItem($lineCharacter2, $lineLength,
                'Średnia cena [zł]', averagePrice), '&#xa;')" />
            <xsl:value-of select="concat(functions:statisticsItem($lineCharacter2, $lineLength,
                'Łaczna liczba różnych gatunków', genreCount), '&#xa;')" />
            <xsl:value-of select="concat(functions:statisticsItem($lineCharacter2, $lineLength,
                'Łaczna liczba wydawców', publisherCount), '&#xa;')" />
            <xsl:value-of select="concat(functions:statisticsItem($lineCharacter2, $lineLength,
                'Najpopularniejszy rodzaj okładki', mostCommonCoverType), '&#xa;')" />
            <xsl:value-of select="concat(functions:drawLineWithTitle($lineCharacter3, $lineLength,
                             ' [Liczba książek na autora]', 'right'), '&#xa;')" />
            <xsl:apply-templates select="bookCountsPerAuthor" />
        </xsl:template>
            <xsl:template name="BookCountsPerAuthor" match="bookCountsPerAuthor">
                <xsl:apply-templates select="authorsBookCount" />
            </xsl:template>
                <xsl:template name="AuthorsBookCount" match="authorsBookCount">
                    <xsl:value-of select="concat(functions:statisticsItem($lineCharacter2, $lineLength,
                        author, bookCount), '&#xa;')" />
                </xsl:template>

    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - Functions -->
    <xsl:function name="functions:drawLine" as="xs:string" >
        <xsl:param name="character" as="xs:string"/>
        <xsl:param name="length" as="xs:integer"/>
        <xsl:sequence select="string-join(for $i in 1 to $length return $character, '')" />
    </xsl:function>
    <xsl:function name="functions:drawLineWithTitle" as="xs:string" >
        <xsl:param name="character" as="xs:string"/>
        <xsl:param name="length" as="xs:integer"/>
        <xsl:param name="title" as="xs:string"/>
        <xsl:param name="align" as="xs:string"/>
        <xsl:choose>
            <xsl:when test="$align = 'left'">
                <xsl:variable name="lineLength" select="xs:integer($length - string-length($title))" />
                <xsl:variable name="line" select="functions:drawLine($character, $lineLength)" />
                <xsl:sequence select="string-join(($title, $line), '')" />
            </xsl:when>
            <xsl:when test="$align = 'center'">
                <xsl:variable name="lineLength" select="xs:integer(($length - string-length($title)) div 2)" />
                <xsl:variable name="line" select="functions:drawLine($character, $lineLength)" />
                <xsl:sequence select="string-join(($line, $title, $line), '')" />
            </xsl:when>
            <xsl:when test="$align = 'right'">
                <xsl:variable name="lineLength" select="xs:integer($length - string-length($title))" />
                <xsl:variable name="line" select="functions:drawLine($character, $lineLength)" />
                <xsl:sequence select="string-join(($line, $title), '')" />
            </xsl:when>
        </xsl:choose>
    </xsl:function>
    <xsl:function name="functions:statisticsItem" as="xs:string" >
        <xsl:param name="character" as="xs:string"/>
        <xsl:param name="length" as="xs:integer"/>
        <xsl:param name="title" as="xs:string"/>
        <xsl:param name="value" as="xs:string"/>
        <xsl:sequence select="concat(
                functions:drawLineWithTitle($character, xs:integer($length div 2), $title, 'right'),
                ' | ',
                functions:drawLineWithTitle($character, xs:integer($length div 2), $value, 'left'))" />
    </xsl:function>

    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - Constants -->
    <xsl:variable name="lineCharacter1"         select="'/'" as="xs:string" />
    <xsl:variable name="lineCharacter2"         select="' '" as="xs:string" />
    <xsl:variable name="lineCharacter3"         select="'-'" as="xs:string" />
    <xsl:variable name="lineLengthTitle"        select="24" as="xs:integer" />
    <xsl:variable name="lineLengthAuthor"       select="24" as="xs:integer" />
    <xsl:variable name="lineLengthGenre"        select="12" as="xs:integer" />
    <xsl:variable name="lineLengthPublisher"    select="18" as="xs:integer" />
    <xsl:variable name="lineLengthPublishYear"  select="16" as="xs:integer" />
    <xsl:variable name="lineLengthCoverType"    select="18" as="xs:integer" />
    <xsl:variable name="lineLengthPages"        select="16" as="xs:integer" />
    <xsl:variable name="lineLengthISBN"         select="24" as="xs:integer" />
    <xsl:variable name="lineLengthPrice"        select="16" as="xs:integer" />
    <xsl:variable name="lineLength"             select="$lineLengthAuthor + $lineLengthTitle +
                                                        $lineLengthGenre + $lineLengthPublisher +
                                                        $lineLengthPublishYear +
                                                        $lineLengthCoverType + $lineLengthPages +
                                                        $lineLengthISBN + $lineLengthPrice"
                                                as="xs:integer" />

</xsl:stylesheet>
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->