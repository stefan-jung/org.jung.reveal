<?xml version="1.0" encoding="UTF-8" ?>
<!-- This file is part of the DITA Open Toolkit plugin 'reveal'.
     The plugin is hosted on Github.com. The plugin is based on
     the JavaScript framework 'reveal.js'. -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output omit-xml-declaration="yes" indent="yes"/>
   
    <!-- Define a newline character -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>
    
   <!--
       This template overrides the template 'generateDefaultCopyright' defined in the 'dita2htmlimpl.xsl'.
       It injects multiple <meta> elements, some CSS and some JavaScript.
   -->
    <xsl:template name="generateDefaultCopyright">
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <link rel="stylesheet" href="css/reveal.min.css" />
        <link rel="stylesheet" href="css/theme/default.css" id="theme" />
        <!-- For syntax highlighting -->
        <link rel="stylesheet" href="lib/css/zenburn.css" />
        <!-- If the query includes 'print-pdf', include the PDF print sheet -->
        <script type="text/javascript">
            if (window.location.search.match(/print-pdf/gi)) {
                var link = document.createElement( 'link' );
                link.rel = 'stylesheet';
                link.type = 'text/css';
                link.href = 'css/print/pdf.css';
                document.getElementsByTagName( 'head' )[0].appendChild( link );
            }
        </script>
        
        <!-- 
            [if lt IE 9]>
            <xsl:value-of select="$newline"/>
            <script src="lib/js/html5shiv.js"></script>
            <xsl:value-of select="$newline"/>
            <![endif]
        -->
    </xsl:template>
    
    <!--
        Override the 'generateCssLinks' template defined
        in the 'dita2htmlimpl.xsl' to get rid of
        the default XHTML CSS links.
    -->
    <xsl:template name="generateCssLinks"/>
    
    <!--
        This template overrides the template 'chapterBody' defined in the 'dita2htmlimpl.xsl'.
        It injects a <div class="reveal"> and a <div class="slides"> element.
    -->
    <xsl:template name="chapterBody">
        <xsl:apply-templates select="." mode="chapterBody"/>
    </xsl:template>
    <xsl:template match="*" mode="chapterBody">
        <body>
            <xsl:value-of select="$newline"/>
            <div class="reveal">
                <!-- Any section element inside of this container is displayed as a slide -->
                <xsl:value-of select="$newline"/>
                <div class="slides">
                    <!-- Already put xml:lang on <html>; do not copy to body with commonattributes -->
                    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]/@outputclass" mode="add-ditaval-style"/>
                    <!--output parent or first "topic" tag's outputclass as class -->
                    <xsl:if test="@outputclass">
                        <xsl:attribute name="class">
                            <xsl:value-of select="@outputclass" />
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="self::dita">
                        <xsl:if test="*[contains(@class, ' topic/topic ')][1]/@outputclass">
                            <xsl:attribute name="class">
                                <xsl:value-of select="*[contains(@class, ' topic/topic ')][1]/@outputclass" />
                            </xsl:attribute>
                        </xsl:if>
                    </xsl:if>
                    <xsl:apply-templates select="." mode="addAttributesToBody"/>
                    <xsl:value-of select="$newline"/>
                    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
                    <xsl:apply-templates/>
                    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
                </div>
            </div>
        
            <!--
                The <br/> tag is necessary to avoid that the <script> tag
                will be collapsed to its shortform: <script/>
                The collapsed <script> tag might not be correctly displayed
                in the browser.
            -->
            <script src="lib/js/head.min.js" type="text/javascript"><br/></script>
            <script src="js/reveal.min.js" type="text/javascript"><br/></script>
            <script type="text/javascript">
                // Full list of configuration options available here:
                // https://github.com/hakimel/reveal.js#configuration
                Reveal.initialize({
                controls: true,
                progress: true,
                history: true,
                center: true,
                
                theme: Reveal.getQueryHash().theme, // available themes are in /css/theme
                transition: Reveal.getQueryHash().transition || 'default', // default/cube/page/concave/zoom/linear/fade/none
                
                // Parallax scrolling
                // parallaxBackgroundImage: 'https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg',
                // parallaxBackgroundSize: '2100px 900px',
                
                // Optional libraries used to extend on reveal.js
                dependencies: [
                { src: 'lib/js/classList.js', condition: function() { return !document.body.classList; } },
                { src: 'plugin/markdown/marked.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
                { src: 'plugin/markdown/markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
                { src: 'plugin/highlight/highlight.js', async: true, callback: function() { hljs.initHighlightingOnLoad(); } },
                { src: 'plugin/zoom-js/zoom.js', async: true, condition: function() { return !!document.body.classList; } },
                { src: 'plugin/notes/notes.js', async: true, condition: function() { return !!document.body.classList; } }
                ]
                });
            </script>
        </body>
    </xsl:template>    
        
    <xsl:template match="//topic">
        <xsl:choose>
            <xsl:when test="topic[not(topic)]">
                <!--
                    Wrap first level topics in a
                    single <section> element.
                -->
                <section>
                    <xsl:apply-templates/>
                </section>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <!--
                        Wrap nested topics in a
                        <section> container.
                    -->
                    <xsl:when test="(count(preceding-sibling::topic) = 0) and (count(following-sibling::topic) >= 1)">
                        <!--
                            Close the section of the parent <topic> element.
                        -->
                        <xsl:text disable-output-escaping="yes">&lt;/section&gt;</xsl:text>
                        <xsl:text disable-output-escaping="yes">&lt;section&gt;</xsl:text>
                        <section>
                            <xsl:apply-templates/>
                        </section>     
                    </xsl:when>
                    <!--
                        TODO: This seems to be obsolte, but why?
                    -->
                    <xsl:when test="(count(preceding-sibling::topic) >= 1) and (count(following-sibling::topic) = 0)">
                        <section>
                            <xsl:apply-templates/>
                        </section>
<!--                    <xsl:text disable-output-escaping="yes">&lt;section id="useless-section"&gt;</xsl:text>
                        <xsl:text disable-output-escaping="yes">&lt;/section&gt;</xsl:text>-->
                    </xsl:when>
                    <xsl:otherwise>
                        <section>
<!--                            Second level REST-->
                            <xsl:apply-templates/>
                        </section>                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
