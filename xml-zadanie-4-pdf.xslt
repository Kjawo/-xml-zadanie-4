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
    <xsl:template name="clientReport" match="/clientReport">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4"
                                       page-width="297mm" page-height="210mm"
                                       margin-top="1cm" margin-bottom="1cm"
                                       margin-left="1cm" margin-right="1cm">
                    <fo:region-body margin="1cm"/>
                    <fo:region-before extent="2cm"/>
                    <fo:region-after extent="2cm"/>
                    <fo:region-start extent="2cm"/>
                    <fo:region-end extent="2cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>


            <xsl:call-template name="ReportGenerationTime" />


            <fo:page-sequence master-reference="A4">
                <fo:flow flow-name="xsl-region-body">
                    <fo:table table-layout="fixed" border="solid 2pt black"  text-align="center">
                        <fo:table-column column-width="20%"/>
                        <fo:table-column column-width="15%"/>
                        <fo:table-column column-width="8%"/>
                        <fo:table-column column-width="13%"/>
                        <fo:table-column column-width="8%"/>
                        <fo:table-column column-width="8%"/>
                        <fo:table-column column-width="5%"/>
                        <fo:table-column column-width="16%"/>
                        <fo:table-column column-width="8%"/>
                        <fo:table-header background-color="silver" border-bottom-style="solid" border-bottom-width="2pt">
                            <fo:table-row>
                                <fo:table-cell padding="2">
                                    <fo:block font-weight="bold">Tytuł</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2">
                                    <fo:block font-weight="bold">Autor</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2">
                                    <fo:block font-weight="bold">Gatunek</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2">
                                    <fo:block font-weight="bold">Wydawca</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2">
                                    <fo:block font-weight="bold">Rok wydania</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2">
                                    <fo:block font-weight="bold">Rodzaj okładki</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2">
                                    <fo:block font-weight="bold">Liczba stron</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2">
                                    <fo:block font-weight="bold">ISBN</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2">
                                    <fo:block font-weight="bold">Cena [zł]</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body>
                            <xsl:apply-templates select="book">
                                <xsl:sort select="title" />
                            </xsl:apply-templates>
                        </fo:table-body>
                    </fo:table>
                </fo:flow>
            </fo:page-sequence>

            <xsl:call-template name="Statistics" />


        </fo:root>
    </xsl:template>
    <xsl:template name="ReportGenerationTime">
        <fo:page-sequence master-reference="A4">
            <fo:flow flow-name="xsl-region-body">
                <fo:block>
                    Czas i data wygenerowania raportu:
                    <xsl:value-of select="/clientReport/reportInformation/reportGenerationTime" />
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
        </xsl:template>

            <xsl:template name="Book" match="book">
                <fo:table-row border-bottom-style="solid">
                    <fo:table-cell padding="2"><fo:block  text-align="left"><xsl:apply-templates select="title" /></fo:block></fo:table-cell>
                    <fo:table-cell padding="2"><fo:block  text-align="left"><xsl:apply-templates select="author" /></fo:block></fo:table-cell>
                    <fo:table-cell padding="2"><fo:block><xsl:apply-templates select="genre" /></fo:block></fo:table-cell>
                    <fo:table-cell padding="2"><fo:block><xsl:apply-templates select="publisher" /></fo:block></fo:table-cell>
                    <fo:table-cell padding="2"><fo:block><xsl:apply-templates select="publishYear" /></fo:block></fo:table-cell>
                    <fo:table-cell padding="2"><fo:block><xsl:apply-templates select="coverType" /></fo:block></fo:table-cell>
                    <fo:table-cell padding="2"><fo:block><xsl:apply-templates select="pages" /></fo:block></fo:table-cell>
                    <fo:table-cell padding="2"><fo:block><xsl:apply-templates select="isbn" /></fo:block></fo:table-cell>
                    <fo:table-cell padding="2"><fo:block><xsl:apply-templates select="price" /></fo:block></fo:table-cell>
                </fo:table-row>
            </xsl:template>
                <xsl:template name="Author" match="author">
                        <xsl:value-of select="." />
                </xsl:template>
                <xsl:template name="Genre" match="genre">
                    <fo:block>
                        <xsl:value-of select="." />
                    </fo:block>
                </xsl:template>
                <xsl:template name="Publisher" match="publisher">
                    <fo:block>
                        <xsl:value-of select="." />
                    </fo:block>
                </xsl:template>
                <xsl:template name="CoverType" match="coverType">
                    <fo:block>
                        <xsl:value-of select="." />
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
            <fo:page-sequence master-reference="A4">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block><xsl:apply-templates select="OverallBookCount" /> </fo:block>
                    <fo:block><xsl:apply-templates select="AveragePageCount" /> </fo:block>
                    <fo:block><xsl:apply-templates select="AveragePrice" /> </fo:block>
                    <fo:block><xsl:apply-templates select="GenreCount" /> </fo:block>
                    <fo:block><xsl:apply-templates select="PublisherCount" /> </fo:block>
                    <fo:block><xsl:apply-templates select="MostCommonCoverType" /> <xsl:text>&#xa;&#xa;</xsl:text></fo:block>
                    <fo:block font-size="9pt">
                        <xsl:apply-templates select="BookCountsPerAuthor">
                            <xsl:sort select="bookCount"/>
                        </xsl:apply-templates>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
        </xsl:template>
            <xsl:template name="OverallBookCount">
                <fo:block>
                    <xsl:value-of select="/clientReport/statistics/overallBookCount" />
                </fo:block>
            </xsl:template>
            <xsl:template name="AveragePageCount" match="averagePageCount">
                <fo:block>
                    <xsl:value-of select="/clientReport/statistics/averagePageCount"/>
                </fo:block>
            </xsl:template>
            <xsl:template name="AveragePrice" match="averagePrice">
                <fo:block>
                    <xsl:value-of select="/clientReport/statistics/averagePrice" />
                </fo:block>
            </xsl:template>
            <xsl:template name="GenreCount" match="genreCount">
                <fo:block>
                    <xsl:value-of select="/clientReport/statistics/genreCount" />
                </fo:block>
            </xsl:template>
            <xsl:template name="PublisherCount" match="publisherCount">
                <fo:block>
                    <xsl:value-of select="/clientReport/statistics/publisherCount" />
                </fo:block>
            </xsl:template>
            <xsl:template name="MostCommonCoverType" match="mostCommonCoverType">
                <fo:block>
                    <xsl:value-of select="/clientReport/statistics/mostCommonCoverType" />
                </fo:block>
            </xsl:template>
            <xsl:template name="BookCountsPerAuthor" match="bookCountsPerAuthor">
                <xsl:apply-templates select="author"/>
                <xsl:apply-templates select="bookCount"/>
            </xsl:template>
            <xsl:template name="BookCount" match="bookCount">
                <fo:block>
                    <xsl:value-of select="/clientReport/statistics/bookCount" />
                </fo:block>
            </xsl:template>

</xsl:stylesheet>
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->