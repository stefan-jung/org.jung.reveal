<?xml version="1.0" encoding="UTF-8" ?>
<!-- 
    This file is part of the DITA Open Toolkit plugin 'org.doctales.reveal'.
    The plugin is hosted on Github.com. The plugin is based on
    the JavaScript framework 'reveal.js'. 
-->

<xsl:stylesheet version="2.0" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="plugin:org.dita.xhtml:xsl/dita2xhtml.xsl"/>
    
    <xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>
    <!-- The parameter $newline defines a line break. -->
    <xsl:variable name="newline">
        <xsl:text>
        </xsl:text>
    </xsl:variable>

    <!-- 
        **************************************************
        Parameters
        **************************************************
    -->
    
    <xsl:param name="args.reveal.css"/>
    <xsl:param name="args.reveal.theme"/>
    <xsl:param name="args.reveal.controls"/>
    <xsl:param name="args.reveal.progress"/>
    <xsl:param name="args.reveal.slidenumber"/>
    <xsl:param name="args.reveal.history"/>
    <xsl:param name="args.reveal.keyboard"/>
    <xsl:param name="args.reveal.overview"/>
    <xsl:param name="args.reveal.center"/>
    <xsl:param name="args.reveal.touch"/>
    <xsl:param name="args.reveal.loop"/>
    <xsl:param name="args.reveal.rtl"/>
    <xsl:param name="args.reveal.fragments"/>
    <xsl:param name="args.reveal.embedded"/>
    <xsl:param name="args.reveal.autoslide"/>
    <xsl:param name="args.reveal.autoslidestoppable"/>
    <xsl:param name="args.reveal.mousewheel"/>
    <xsl:param name="args.reveal.hideaddressbar"/>
    <xsl:param name="args.reveal.previewlinks"/>
    <xsl:param name="args.reveal.transition"/>
    <xsl:param name="args.reveal.transitionspeed"/>
    <xsl:param name="args.reveal.backgroundtransition"/>
    <xsl:param name="args.reveal.viewdistance"/>
    <xsl:param name="args.reveal.parallaxbackgroundimage"/>
    <xsl:param name="args.reveal.parallaxbackgroundsize"/>
    <xsl:param name="args.reveal.generate.vertical.slides"/>
    <xsl:param name="args.reveal.width"/>
    <xsl:param name="args.reveal.height"/>
    <xsl:param name="args.reveal.margin"/>
    <xsl:param name="args.reveal.minScale"/>
    <xsl:param name="args.reveal.maxScale"/>
    
    <!--
        **************************************************
        Templates
        **************************************************
    -->
    
    <xsl:template match="/">
        <xsl:apply-imports/>
    </xsl:template>
    
    <!-- Add reveal.js styles by overriding placeholder template from dita2htmlImpl.xsl -->
    <xsl:template match="/|node()|@*" mode="gen-user-styles">
        
        <meta name="apple-mobile-web-app-capable" content="yes"><!----></meta>
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"><!----></meta>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, minimal-ui"><!----></meta>
        
        <link rel="stylesheet" href="css/reveal.css"><!----></link>
        <xsl:if test="not(contains($args.reveal.theme, 'null'))">
            <link rel="stylesheet" href="css/theme/{$args.reveal.theme}.css" id="theme"><!----></link>
        </xsl:if>

        <!-- Code syntax highlighting -->
        <link href="lib/css/zenburn.css" rel="stylesheet"/>

        <!-- For print -->
        
        <!-- Printing and PDF exports -->
        <script>
            var link = document.createElement( 'link' );
            link.rel = 'stylesheet';
            link.type = 'text/css';
            link.href = window.location.search.match( /print-pdf/gi ) ? 'css/print/pdf.css' : 'css/print/paper.css';
            document.getElementsByTagName( 'head' )[0].appendChild( link );
        </script>
        
        <!--[if lt IE 9]>
		<script src="lib/js/html5shiv.js"></script>
		<![endif]-->
    </xsl:template>
    
    <!-- Add title by overriding placeholder template from dita2htmlImpl.xsl -->
    <xsl:template match="/|node()|@*" mode="gen-user-panel-title-pfx"></xsl:template>
    
    <!--
        This template overrides the template 'chapterBody' defined in the 'dita2htmlimpl.xsl'.
        It injects a <div class="reveal"> and a <div class="slides"> element.
    -->
    <xsl:template name="chapterBody">
        <xsl:apply-templates select="." mode="chapterBody"/>
    </xsl:template>
    
    <xsl:template match="*" mode="chapterBody">
        <!--<body onload="removeDisposableSections()">--> 
        <body> 
            <div class="reveal">
                <!-- Any section element inside of this container is displayed as a slide -->
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
                    <xsl:variable name="bodyContent">
                        <xsl:apply-templates/>
                    </xsl:variable>
                    <!-- Post-process all the topic container elements and generate proper sections for them -->
                    <xsl:for-each select="$bodyContent/*">
                        <xsl:choose>
                            <xsl:when test="count(.//topicContainer) > 0">
                                <!-- We need to bring all slides to the top level -->
                                <xsl:variable name="allSlidesAsFirstLevel">
                                    <!-- The slide which contains other slides, copied to output but ignoring sub-slides -->
                                    <section>
                                        <xsl:apply-templates mode="all-but-topicContainer"/>
                                    </section>
                                    <!-- For each subslide, copy to output but ignore sub-slides -->
                                    <xsl:for-each select=".//topicContainer">
                                        <section>
                                            <xsl:apply-templates mode="all-but-topicContainer"/>
                                        </section>
                                    </xsl:for-each>
                                </xsl:variable>
                                <xsl:choose>
                                    <xsl:when test="$args.reveal.generate.vertical.slides = 'true'">
                                        <!-- Generate vertical slides, so wrap in a <section> element -->
                                        <section>
                                            <xsl:copy-of select="$allSlidesAsFirstLevel"/>
                                        </section>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <!-- No vertical slides generation -->
                                        <xsl:copy-of select="$allSlidesAsFirstLevel"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <section>
                                    <xsl:apply-templates mode="all-but-topicContainer"/>
                                </section>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
                </div>
            </div>
            
            <script src="lib/js/head.min.js" type="text/javascript"><!----></script><xsl:value-of select="$newline"/>
            <script src="js/reveal.js" type="text/javascript"><!----></script><xsl:value-of select="$newline"/>
            <script src="js/jquery-1.11.3.min.js" type="text/javascript"><!----></script><xsl:value-of select="$newline"/>
            <script type="text/javascript">
                <!-- 
                    Full list of configuration options available here:
                    https://github.com/hakimel/reveal.js#configuration
                -->
                Reveal.initialize({
                    controls: <xsl:value-of select="$args.reveal.controls"/>,
                    progress: <xsl:value-of select="$args.reveal.progress"/>,
                    slideNumber: <xsl:value-of select="$args.reveal.slidenumber"/>,
                    history: <xsl:value-of select="$args.reveal.hideaddressbar"/>,
                    keyboard: <xsl:value-of select="$args.reveal.keyboard"/>,
                    overview: <xsl:value-of select="$args.reveal.overview"/>,
                    center: <xsl:value-of select="$args.reveal.center"/>,
                    touch: <xsl:value-of select="$args.reveal.touch"/>,
                    loop: <xsl:value-of select="$args.reveal.loop"/>,
                    rtl: <xsl:value-of select="$args.reveal.rtl"/>,
                    fragments: <xsl:value-of select="$args.reveal.fragments"/>,
                    embedded: <xsl:value-of select="$args.reveal.embedded"/>,
                    autoSlide: <xsl:value-of select="$args.reveal.autoslide"/>,
                    autoSlideStoppable: <xsl:value-of select="$args.reveal.autoslidestoppable"/>,
                    mouseWheel: <xsl:value-of select="$args.reveal.mousewheel"/>,
                    hideAddressBar: <xsl:value-of select="$args.reveal.hideaddressbar"/>,
                    previewLinks: <xsl:value-of select="$args.reveal.previewlinks"/>,
                    transition: '<xsl:value-of select="$args.reveal.transition"/>',
                    transitionSpeed: '<xsl:value-of select="$args.reveal.transitionspeed"/>',
                    backgroundTransition: '<xsl:value-of select="$args.reveal.backgroundtransition"/>',
                    viewDistance: <xsl:value-of select="$args.reveal.viewdistance"/>,
                    // parallaxBackgroundImage: '<xsl:value-of select="$args.reveal.parallaxbackgroundimage"/>',
                    // parallaxBackgroundSize: '<xsl:value-of select="$args.reveal.parallaxbackgroundsize"/>',
                    // parallaxBackgroundHorizontal: null,
                    // parallaxBackgroundVertical: null,
                    width: <xsl:value-of select="$args.reveal.width"/>,
                    height: <xsl:value-of select="$args.reveal.height"/>,
                    margin: <xsl:value-of select="$args.reveal.margin"/>,
                    minScale: <xsl:value-of select="$args.reveal.minScale"/>,
                    maxScale: <xsl:value-of select="$args.reveal.maxScale"/>,
                    
                    theme: Reveal.getQueryHash().theme, // available themes are in /css/theme
                    transition: Reveal.getQueryHash().transition || 'default', // default/cube/page/concave/zoom/linear/fade/none
                    
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
                
                Reveal.addEventListener( 'slidechanged', function( event ) {
                zoomSection();
                } );
                
                $( document ).ready(function() {
                });
            </script>
        </body>
    </xsl:template>    
    
    <!--
        Process topics.
    -->
    <xsl:template match="*[contains(@class, ' topic/topic ')]">
        <!-- Just a placeholder which will be replaced with <section> -->
        <topicContainer>
            <xsl:apply-templates/>
        </topicContainer>
    </xsl:template>
    
<!--    <!-\- Override template to remove related-links block -\->
    <xsl:template match="*[contains(@class, ' topic/related-links ')]" name="topic.related-links">
        <!-\- Do nothing -\->
    </xsl:template>
    
    <!-\- Override template to remove nav titles -\->
    <xsl:template match="*" mode="get-navtitle">
        <!-\- Do nothing -\->
    </xsl:template>-->
        
    
    <!--
        Process codeblock elements.
        The attribute @outputclass defines the highlighted language.
        The highlighting is done by highlight.js.
        The supported languages of highlight.js can be found here:
        https://highlightjs.org/static/test.html
        
        You have to prefix the value of the @outputclass element with 'language-'.
        Example:
        To highlight a Java-codeblock, write:
        <codeblock outputclass="language-java">
            public void foo(String bar) {
                System.out.println("bar");
            }
        </codeblock>
    -->
    <xsl:template match="*[contains(@class,' pr-d/codeblock ')][contains(@outputclass, 'language-')]">
        <pre>
            <code>
                <xsl:attribute name="class">hljs <xsl:value-of select="substring-after(@outputclass,'language-')"/></xsl:attribute>
                <xsl:apply-templates/>
            </code>
        </pre>
    </xsl:template>
    
    <!-- Process slides - Override template from dita2xhtml-util.xsl -->
    
    <xsl:template match="nav | section | figure | article" mode="add-xhtml-ns" priority="20">
        <xsl:element name="section" namespace="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="@* except @role | node()" mode="add-xhtml-ns"/>
        </xsl:element>
    </xsl:template>
    
    <!-- 
        Override template from dita2htmlImpl.xsl.
        DITA <section> elements have to be transformed to <div> elements,
        because reveal.js handles <section> elements as slides.
    -->
    <!-- section processor - div with no generated title -->
    <xsl:template match="*[contains(@class, ' topic/section ')]" name="topic.section">
        <div class="section">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="gen-toc-id"/>
            <xsl:call-template name="setidaname"/>
            <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
            
            <!--<xsl:apply-templates select="." mode="dita2html:section-heading"/>-->
            
            <xsl:apply-templates select="*[not(contains(@class, ' topic/title '))] | text() | comment() | processing-instruction()"/>
            <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
        </div><xsl:value-of select="$newline"/>
    </xsl:template>
    
    <!-- Deep copy template -->
    <xsl:template match="*|text()|@*" mode="all-but-topicContainer">
        <xsl:choose>
            <xsl:when test="'topicContainer' = local-name()">
                <!-- Ignore -->
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates mode="all-but-topicContainer" select="@*"/>
                    <xsl:apply-templates mode="all-but-topicContainer"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
