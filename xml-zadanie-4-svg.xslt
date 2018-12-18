<?xml version="1.0" encoding="UTF-8"?>
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->
<!-- File: xml-zadanie-4-svg.xslt -->
<!-- Authors: Konrad Jaworski, Tomasz Witczak -->
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns="http://www.w3.org/2000/svg">
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  Output -->
    <xsl:output method="xml" indent="yes" media-type="image/svg" />

    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - Templates -->
    <xsl:template name="ClientReport" match="/clientReport">
        <xsl:text disable-output-escaping='yes'>
            &lt;!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"&gt;
        </xsl:text>

        <svg xmlns="http://www.w3.org/2000/svg" width="1680" height="1260" >
            <desc>Wykresy w formacie .svg</desc>
            <title>Raport dla klienta (wykresy)</title>
            <style>
                :root {
                --color1: #90afc5;
                --color2: #336b87;
                --color3: #2a3132;
                --color4: #763626;
                background-color: var(--color3);
                font-family: Palatino;
                fill: var(--color1);
                font-size: 100%;
                }

                #drawTitleText {
                font-size: 5em;
                font-weight: bold;
                letter-spacing: 5px;
                }


                .graph {
                height: 500px;
                width: 800px;
                }
                .graph .labels.x-labels {
                text-anchor: middle;
                }
                .graph .labels.y-labels {
                text-anchor: end;
                }
                .graph .grid {
                stroke: var(--color2);
                stroke-dasharray: 0;
                stroke-width: 1;
                }
                .labels {
                font-size: 1em;
                }
                .label-title {
                font-style: italic;
                text-transform: lowercase;
                font-size: 1.25em;
                }
                .data {
                fill: var(--color4);
                transition: fill .3s ease;
                cursor: pointer;
                }
                .data text {
                display: none;
                }
                .data:hover,
                .data:focus {
                fill: var(--color2);
                }
                .data:hover text, .data:focus text {
                display: block;
                fill: var(--color2);
                }
                #titleAutorzy {
                    writing-mode: vertical-rl;
                    text-orientation: upright;
                }
                a {
                fill: var(--color2);
                cursor: pointer;
                font-style: italic;
                font-size: 1.25em;
                }
            </style>
            <script type="text/javascript"><![CDATA[
                function dataClick(evt) {
                    var dataRect = evt.target;
                    var currentFill = dataRect.getAttributeNS(null, "fill");
                    if(currentFill == "green")
                        dataRect.setAttributeNS(null, "fill", "red");
                    else
                        dataRect.setAttributeNS(null, "fill", "green");
                }
            ]]></script>

            <g>
                <xsl:call-template name="DrawTitle" />
                <xsl:call-template name="DrawBookCountPerAuthorChart" />
                <xsl:call-template name="DrawPriceChart" />

                <g>
                    <a href="#drawTitleText">
                        <text x="575" y="1200">Przejdź do góry strony</text>
                    </a>
                </g>

                <xsl:element name="animate">
                    <xsl:attribute name="attributeName" select="'opacity'" />
                    <xsl:attribute name="attributeType" select="'XML'" />
                    <xsl:attribute name="begin" select="'0s'" />
                    <xsl:attribute name="dur" select="'1s'" />
                    <xsl:attribute name="fill" select="'freeze'" />
                    <xsl:attribute name="from" select="0" />
                    <xsl:attribute name="to" select="1" />
                </xsl:element>
            </g>
        </svg>
    </xsl:template>
        <xsl:template name="DrawTitle">
            <text x="300" y="100" id="drawTitleText">
                Raport (statystyki)
            </text>
        </xsl:template>

        <xsl:template name="DrawBookCountPerAuthorChart">
            <g class="graph" transform="translate(100 200)">
                <g class="grid x-grid" id="xGrid">
                    <line x1="100" x2="100" y1="5" y2="305"></line>
                </g>
                <g class="grid y-grid" id="yGrid">
                    <line x1="100" x2="525" y1="305" y2="305"></line>
                </g>
                <g class="labels x-labels">
                    <text x="100" y="340">0</text>
                    <text x="150" y="340">1</text>
                    <text x="200" y="340">2</text>
                    <text x="250" y="340">3</text>
                    <text x="300" y="340">4</text>
                    <text x="350" y="340">5</text>
                    <text x="400" y="340">6</text>
                    <text x="450" y="340">7</text>
                    <text x="500" y="340">8</text>
                    <text x="325" y="0" class="label-title">Liczba książek na danego autora</text>
                </g>
                <g class="labels y-labels">
                    <text x="80" y="40">Umberto Eco</text>
                    <text x="80" y="80">John Green</text>
                    <text x="80" y="120">Stephen King</text>
                    <text x="80" y="160">George Martin</text>
                    <text x="80" y="200">Bolesław Prus</text>
                    <text x="80" y="240">Andrzej Sapkowski</text>
                    <text x="80" y="280">Henryk Sienkiewicz</text>
                </g>
                <xsl:for-each select="/clientReport/statistics/bookCountsPerAuthor/authorsBookCount">
                    <g class="data">
                        <xsl:element name="rect">
                            <xsl:attribute name="onclick" select="'dataClick(this)'" />
                            <xsl:attribute name="width" select="bookCount*50" />
                            <xsl:attribute name="height" select="20" />
                            <xsl:attribute name="x" select="101" />
                            <xsl:attribute name="y" select="25+40*(position()-1)" />
                            <xsl:element name="animate">
                                <xsl:attribute name="attributeName" select="'width'" />
                                <xsl:attribute name="attributeType" select="'XML'" />
                                <xsl:attribute name="begin" select="'0s'" />
                                <xsl:attribute name="dur" select="'1s'" />
                                <xsl:attribute name="fill" select="'freeze'" />
                                <xsl:attribute name="from" select="0" />
                                <xsl:attribute name="to" select="bookCount*50" />
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="text">
                            <xsl:attribute name="x" select="110+bookCount*50" />
                            <xsl:attribute name="y" select="40+40*(position()-1)" />
                            <xsl:value-of select="bookCount" />
                            <xsl:element name="animate">
                                <xsl:attribute name="attributeName" select="'x'" />
                                <xsl:attribute name="attributeType" select="'XML'" />
                                <xsl:attribute name="begin" select="'0s'" />
                                <xsl:attribute name="dur" select="'1s'" />
                                <xsl:attribute name="fill" select="'freeze'" />
                                <xsl:attribute name="from" select="0" />
                                <xsl:attribute name="to" select="110+bookCount*50" />
                            </xsl:element>
                        </xsl:element>
                    </g>
                </xsl:for-each>
            </g>
        </xsl:template>

        <xsl:template name="DrawPriceChart">
            <g class="graph" transform="translate(750 200)">
                <g class="grid x-grid" id="xGrid">
                    <line x1="100" x2="100" y1="5" y2="865"></line>
                </g>
                <g class="grid y-grid" id="yGrid">
                    <line x1="100" x2="525" y1="865" y2="865"></line>
                </g>
                <g class="labels x-labels">
                    <text x="100" y="900">0</text>
                    <text x="150" y="900">10</text>
                    <text x="200" y="900">20</text>
                    <text x="250" y="900">30</text>
                    <text x="300" y="900">40</text>
                    <text x="350" y="900">50</text>
                    <text x="400" y="900">60</text>
                    <text x="450" y="900">70</text>
                    <text x="500" y="900">80</text>
                    <text x="325" y="0" class="label-title">Cena danej książki [zł]</text>
                </g>
                <g class="labels y-labels">
                    <xsl:for-each select="/clientReport/book">
                        <xsl:element name="text">
                            <xsl:attribute name="x" select="80" />
                            <xsl:attribute name="y" select="40+(position()-1)*40" />
                            <xsl:value-of select="title" />
                        </xsl:element>
                    </xsl:for-each>
                </g>
                <xsl:for-each select="/clientReport/book">
                    <g class="data">
                        <xsl:element name="rect">
                            <xsl:attribute name="width" select="price*5" />
                            <xsl:attribute name="height" select="20" />
                            <xsl:attribute name="x" select="101" />
                            <xsl:attribute name="y" select="25+40*(position()-1)" />
                            <xsl:attribute name="onmouseover" select="'dataMouseOver()'" />
                            <xsl:element name="animate">
                                <xsl:attribute name="attributeName" select="'width'" />
                                <xsl:attribute name="attributeType" select="'XML'" />
                                <xsl:attribute name="begin" select="'0s'" />
                                <xsl:attribute name="dur" select="'1s'" />
                                <xsl:attribute name="fill" select="'freeze'" />
                                <xsl:attribute name="from" select="0" />
                                <xsl:attribute name="to" select="price*5" />
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="text">
                            <xsl:attribute name="x" select="110+price*5" />
                            <xsl:attribute name="y" select="40+40*(position()-1)" />
                            <xsl:value-of select="price" />
                            <xsl:element name="animate">
                                <xsl:attribute name="attributeName" select="'x'" />
                                <xsl:attribute name="attributeType" select="'XML'" />
                                <xsl:attribute name="begin" select="'0s'" />
                                <xsl:attribute name="dur" select="'1s'" />
                                <xsl:attribute name="fill" select="'freeze'" />
                                <xsl:attribute name="from" select="0" />
                                <xsl:attribute name="to" select="110+price*5" />
                            </xsl:element>
                        </xsl:element>
                    </g>
                </xsl:for-each>
            </g>
        </xsl:template>

        <xsl:template name="Statistics" match="statistics">
        <!--        <xsl:call-template name="OverallBookCount" /> -->
                <xsl:call-template name="BookCountsPerAuthor" />
        </xsl:template>
      <!--      <xsl:template name="OverallBookCount">
                    <xsl:value-of select="count(/bookStore/books/book)" />
            </xsl:template> -->
            <xsl:template name="BookCountsPerAuthor">
                <svg xmlns="http://www.w3.org/2000/svg"
                     width="1280" height="960" >
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

    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - Constants -->
    <xsl:param name="width" select="40" />
    <xsl:param name="space" select="10" />
    <xsl:variable name="max-y" select="100" />

</xsl:stylesheet>
<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->