<?xml version="1.0" encoding="UTF-8"?>
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->
<!-- File: xml-zadanie-4-pdf.xslt -->
<!-- Authors: Konrad Jaworski, Tomasz Witczak -->
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  Output -->
    <xsl:output method="xml" version="1.0" encoding="utf-8" />
    
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - Templates -->
    <xsl:template name="ClientReport" match="/clientReport">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4"
                                       page-width="297mm" page-height="210mm"
                                       margin-top="0.25cm" margin-bottom="0.5cm"
                                       margin-left="1cm" margin-right="1cm">
                    <fo:region-body margin="1cm" />
                    <fo:region-before extent="2cm" />
                    <fo:region-after extent="2cm" />
                    <fo:region-start extent="2cm" />
                    <fo:region-end extent="2cm" />
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="A4">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="1.5cm" font-weight="bold" text-align="center">
                        Spis książek
                    </fo:block>
                    <fo:block text-align="center" padding="5mm">
                        Czas i data wygenerowania raportu:
                        <xsl:value-of select="reportInformation/reportGenerationTime" />
                    </fo:block>
                    <fo:table table-layout="fixed" border="solid 2pt black" text-align="center">
                        <fo:table-column column-width="20%" />
                        <fo:table-column column-width="15%" />
                        <fo:table-column column-width="8%" />
                        <fo:table-column column-width="13%" />
                        <fo:table-column column-width="8%" />
                        <fo:table-column column-width="8%" />
                        <fo:table-column column-width="5%" />
                        <fo:table-column column-width="16%" />
                        <fo:table-column column-width="8%" />
                        <fo:table-header background-color="silver" border-bottom-style="solid"
                                         border-bottom-width="2pt">
                            <fo:table-row>
                                <fo:table-cell padding="0.5mm">
                                    <fo:block font-weight="bold">
                                        Tytuł
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="0.5mm">
                                    <fo:block font-weight="bold">
                                        Autor
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="0.5mm">
                                    <fo:block font-weight="bold">
                                        Gatunek
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="0.5mm">
                                    <fo:block font-weight="bold">
                                        Wydawca
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="0.5mm">
                                    <fo:block font-weight="bold">
                                        Rok wydania
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="0.5mm">
                                    <fo:block font-weight="bold">
                                        Rodzaj okładki
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="0.5mm">
                                    <fo:block font-weight="bold">
                                        Liczba stron
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="0.5mm">
                                    <fo:block font-weight="bold">
                                        ISBN
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="0.5mm">
                                    <fo:block font-weight="bold">
                                        Cena [zł]
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body>
                            <xsl:apply-templates select="book">
                                <xsl:sort select="title" />
                            </xsl:apply-templates>
                        </fo:table-body>
                    </fo:table>
                    <xsl:apply-templates select="statistics" />
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    <xsl:template name="Book" match="book">
        <fo:table-row border-bottom-style="solid">
            <fo:table-cell padding="0.5mm">
                <fo:block text-align="left">
                    <xsl:apply-templates select="title" />
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="0.5mm">
                <fo:block text-align="left">
                    <xsl:apply-templates select="author" />
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="0.5mm">
                <fo:block>
                    <xsl:apply-templates select="genre" />
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="0.5mm">
                <fo:block>
                    <xsl:apply-templates select="publisher" />
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="0.5mm">
                <fo:block>
                    <xsl:apply-templates select="publishYear" />
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="0.5mm">
                <fo:block>
                    <xsl:apply-templates select="coverType" />
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="0.5mm">
                <fo:block>
                    <xsl:apply-templates select="pages" />
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="0.5mm">
                <fo:block>
                    <xsl:apply-templates select="isbn" />
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding="0.5mm">
                <fo:block>
                    <xsl:apply-templates select="price" />
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
    <xsl:template name="Author" match="author|genre|publisher|coverType|title|pages|publishYear|
                                       price|isbn">
        <xsl:value-of select="." />
    </xsl:template>
    <xsl:template name="Statistics" match="statistics">
        <fo:block font-size="1.5cm" font-weight="bold" text-align="center">
            Statystyki
        </fo:block>
        <fo:block-container margin-top="1cm">
            <fo:block-container absolute-position="absolute" left="0mm">
                <fo:table table-layout="fixed" border="solid 2pt black" text-align="center">
                    <fo:table-column column-width="30%" background-color="silver"
                                     border-right-style="solid" border-bottom-width="2pt" />
                    <fo:table-column column-width="10%" />
                    <fo:table-body border-bottom-style="solid" border-bottom-width="2pt">
                        <fo:table-row border-bottom-style="solid" border-bottom-width="2pt">
                            <fo:table-cell padding="0.5mm">
                                <fo:block font-weight="bold">
                                    Łączna liczba książek
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:apply-templates select="overallBookCount" />
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row border-bottom-style="solid" border-bottom-width="2pt">
                            <fo:table-cell padding="0.5mm">
                                <fo:block font-weight="bold">
                                    Średnia liczba stron
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:apply-templates select="averagePageCount" />
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row border-bottom-style="solid" border-bottom-width="2pt">
                            <fo:table-cell padding="0.5mm">
                                <fo:block font-weight="bold">
                                    Średnia cena [zł]
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:apply-templates select="averagePrice" />
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row border-bottom-style="solid" border-bottom-width="2pt">
                            <fo:table-cell padding="0.5mm">
                                <fo:block font-weight="bold">
                                    Łaczna liczba różnych gatunków
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:apply-templates select="genreCount" />
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row border-bottom-style="solid" border-bottom-width="2pt">
                            <fo:table-cell padding="0.5mm">
                                <fo:block font-weight="bold">
                                    Łaczna liczba wydawców
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:apply-templates select="publisherCount" />
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell padding="0.5mm">
                                <fo:block font-weight="bold">
                                    Najpopularniejszy rodzaj okładki
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="0.5mm">
                                <fo:block>
                                    <xsl:apply-templates select="mostCommonCoverType" />
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </fo:block-container>
            <fo:block-container absolute-position="absolute" left="140mm" width="100%">
                <fo:table table-layout="fixed" border="solid 2pt black" text-align="center">
                    <fo:table-column column-width="20%" />
                    <fo:table-column column-width="15%" />
                    <fo:table-header background-color="silver" border-bottom-style="solid"
                                     border-bottom-width="2pt">
                        <fo:table-row>
                            <fo:table-cell padding="0.5mm">
                                <fo:block font-weight="bold">
                                    Autor:
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="0.5mm">
                                <fo:block font-weight="bold">
                                    Ilość książek:
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-header>
                    <fo:table-body>
                        <xsl:apply-templates select="bookCountsPerAuthor" />
                    </fo:table-body>
                </fo:table>
            </fo:block-container>
        </fo:block-container>
    </xsl:template>
        <xsl:template name="OverallBookCount" match="overallBookCount|averagePageCount|averagePrice|
                                                     genreCount|publisherCount|mostCommonCoverType">
            <fo:block>
                <xsl:value-of select="." />
            </fo:block>
        </xsl:template>
        <xsl:template name="BookCountsPerAuthor" match="bookCountsPerAuthor">
            <xsl:apply-templates select="authorsBookCount" />
        </xsl:template>
            <xsl:template name="AuthorsBookCount" match="authorsBookCount">
            <fo:table-row border="solid 2pt black" text-align="center">
                <fo:table-cell>
                    <fo:block>
                        <xsl:value-of select="author" />
                    </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                    <fo:block>
                        <xsl:value-of select="bookCount" />
                    </fo:block>
                </fo:table-cell>
            </fo:table-row>
        </xsl:template>
    
</xsl:stylesheet>
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->