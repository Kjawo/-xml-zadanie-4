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
                        <xsl:call-template name="ReportGenerationTime" />
                        <xsl:apply-templates select="books" />
                        <xsl:call-template name="Statistics" />
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>

        </fo:root>
    </xsl:template>
    <xsl:template name="ReportGenerationTime">
            <fo:block>Report generation time:
                <xsl:value-of select="." />
            </fo:block>

        </xsl:template> 
        <xsl:template name="Books" match="books">
            <xsl:apply-templates select="book">
                <xsl:sort select="title" />
            </xsl:apply-templates>
        </xsl:template>
            <xsl:template name="Book" match="book">
                    <xsl:apply-templates select="title" />
                    <xsl:apply-templates select="author" />
                    <xsl:apply-templates select="genre" />
                    <xsl:apply-templates select="publisher" />
                    <xsl:apply-templates select="publishYear" />
                    <xsl:apply-templates select="coverType" />
                    <xsl:apply-templates select="pages" />
                    <xsl:apply-templates select="isbn" />
                    <xsl:apply-templates select="price" />
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
            <fo:block><xsl:call-template name="OverallBookCount" /> </fo:block>
            <fo:block><xsl:call-template name="AveragePageCount" /> </fo:block>
            <fo:block><xsl:call-template name="AveragePrice" /> </fo:block>
            <fo:block><xsl:call-template name="GenreCount" /> </fo:block>
            <fo:block><xsl:call-template name="PublisherCount" /> </fo:block>
            <fo:block><xsl:call-template name="MostCommonCoverType" /> <xsl:text>&#xa;&#xa;</xsl:text></fo:block>
            <fo:block>
                <xsl:apply-templates select="BookCountsPerAuthor">
                    <xsl:sort select="bookCount"/>
                </xsl:apply-templates>
            </fo:block>
        </xsl:template>
            <xsl:template name="OverallBookCount" match="overallBookCount">
                <fo:block>
                    <xsl:value-of select="." />
                </fo:block>
            </xsl:template>
            <xsl:template name="AveragePageCount" match="averagePageCount">
                <fo:block>
                    <xsl:value-of select="." />
                </fo:block>
            </xsl:template>
            <xsl:template name="AveragePrice" match="averagePageCount">
                <fo:block>
                    <xsl:value-of select="." />
                </fo:block>
            </xsl:template>
            <xsl:template name="GenreCount" match="averagePageCount">
                <fo:block>
                    <xsl:value-of select="." />
                </fo:block>
            </xsl:template>
            <xsl:template name="PublisherCount" match="averagePageCount">
                <fo:block>
                    <xsl:value-of select="." />
                </fo:block>
            </xsl:template>
            <xsl:template name="MostCommonCoverType" match="averagePageCount">
                <fo:block>
                    <xsl:value-of select="." />
                </fo:block>
            </xsl:template>
            <xsl:template name="BookCountsPerAuthor" match="bookCountsPerAuthor">
                <xsl:apply-templates select="author"/>

            </xsl:template>
            <xsl:template name="BookCount" match="bookCount">
                <fo:block>
                    <xsl:value-of select="." />
                </fo:block>
            </xsl:template>

</xsl:stylesheet>
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->