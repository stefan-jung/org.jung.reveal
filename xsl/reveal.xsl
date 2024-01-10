<?xml version="1.0" encoding="UTF-8" ?>
<!-- 
    This file is part of the DITA Open Toolkit plugin 'org.jung.reveal'.
    The plugin is hosted on Github.com. The plugin is based on
    the JavaScript framework 'reveal.js'. 
-->

<xsl:stylesheet version="3.0" 
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="#all">
    
    <xsl:import href="plugin:org.dita.html5:xsl/dita2html5Impl.xsl"/>
    <xsl:output method="html" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>


    <!-- 
        **************************************************
        DEBUGGING
        **************************************************
    -->
    <!-- When activating this, the output is invalid HTML5, but the elements have some useful identifiers. -->
    <xsl:variable name="debugging" as="xs:boolean" select="false()"/>

    <!-- 
        **************************************************
        Parameters
        **************************************************
    -->
    
    <xsl:param name="reveal.autoslide"/>
    <xsl:param name="reveal.autoAnimate"/>
    <xsl:param name="reveal.autoAnimateMatcher" select="'null'"/>
    <xsl:param name="reveal.autoAnimateEasing" select="'ease'"/>
    <xsl:param name="reveal.autoAnimateDuration" select="'1.0'"/>
    <xsl:param name="reveal.autoAnimateUnmatched"/>
    <xsl:param name="reveal.autoPlayMedia"/>
    <xsl:param name="reveal.autoslidestoppable"/>
    <xsl:param name="reveal.backgroundtransition"/>
    <xsl:param name="reveal.center"/>
    <xsl:param name="reveal.controls"/>
    <xsl:param name="reveal.controlsBackArrows"/>
    <xsl:param name="reveal.controlsLayout"/>
    <xsl:param name="reveal.controlsTutorial"/>
    <xsl:param name="reveal.css"/>
    <xsl:param name="reveal.disableLayout"/>
    <xsl:param name="reveal.embedded"/>
    <xsl:param name="reveal.fragments"/>
    <xsl:param name="reveal.fragmentInURL"/>
    <xsl:param name="reveal.generate.vertical.slides"/>
    <xsl:param name="reveal.hash"/>
    <xsl:param name="reveal.height"/>
    <xsl:param name="reveal.help"/>
    <xsl:param name="reveal.hideaddressbar"/>
    <xsl:param name="reveal.hashOneBasedIndex"/>
    <xsl:param name="reveal.history"/>
    <xsl:param name="reveal.jumpToSlide"/>
    <xsl:param name="reveal.keyboard"/>
    <xsl:param name="reveal.keyboardCondition"/>
    <xsl:param name="reveal.loop"/>
    <xsl:param name="reveal.margin"/>
    <xsl:param name="reveal.maxScale"/>
    <xsl:param name="reveal.minScale"/>
    <xsl:param name="reveal.mousewheel"/>
    <xsl:param name="reveal.navigationMode"/>
    <xsl:param name="reveal.overview"/>
    <xsl:param name="reveal.parallaxBackgroundImage"/>
    <xsl:param name="reveal.parallaxBackgroundSize"/>
    <xsl:param name="reveal.pause"/>
    <xsl:param name="reveal.preloadIframes"/>
    <xsl:param name="reveal.previewlinks"/>
    <xsl:param name="reveal.progress"/>
    <xsl:param name="reveal.respondToHashChanges"/>
    <xsl:param name="reveal.rtl"/>
    <xsl:param name="reveal.scrollProgress"/>
    <xsl:param name="reveal.slidenumber"/>
    <xsl:param name="reveal.showHiddenSlides"/>
    <xsl:param name="reveal.showNotes"/>
    <xsl:param name="reveal.showSlideNumber"/>
    <xsl:param name="reveal.shuffle"/>
    <xsl:param name="reveal.theme"/>
    <xsl:param name="reveal.touch"/>
    <xsl:param name="reveal.transition"/>
    <xsl:param name="reveal.transitionspeed"/>
    <xsl:param name="reveal.view"/>
    <xsl:param name="reveal.viewdistance"/>
    <xsl:param name="reveal.width"/>
    
    
    <!--
        **************************************************
        Modes
        **************************************************
    -->
    <xsl:mode name="reveal-slide-attributes" on-no-match="shallow-skip"/>
    
    
    <!--
        **************************************************
        Templates
        **************************************************
    -->
    
    <!-- Add reveal.js styles by overriding placeholder template from dita2htmlImpl.xsl -->
    <xsl:template match="/|node()|@*" mode="gen-user-styles">
        
        <meta charset="utf-8"><!-- --></meta>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"><!-- --></meta>
        
        <link rel="stylesheet" href="dist/reset.css"><!----></link>
        <link rel="stylesheet" href="dist/reveal.css"><!----></link>
        <xsl:choose>
            <xsl:when test="not(contains($reveal.theme, 'null'))">
                <link rel="stylesheet" href="dist/theme/{$reveal.theme}.css" id="theme"><!----></link>    
            </xsl:when>
            <xsl:otherwise>
                <link rel="stylesheet" href="dist/reveal.css" id="theme"><!----></link>
            </xsl:otherwise>
        </xsl:choose>
                    
        <!-- Theme used for syntax highlighted code -->
        <link rel="stylesheet" href="plugin/highlight/monokai.css" id="highlight-theme"><!----></link>

        <!-- For print -->
        
        <!-- Printing and PDF exports -->
        <!--<script>
            var link = document.createElement( 'link' );
            link.rel = 'stylesheet';
            link.type = 'text/css';
            link.href = window.location.search.match( /print-pdf/gi ) ? 'css/print/pdf.css' : 'css/print/paper.css';
            document.getElementsByTagName( 'head' )[0].appendChild( link );
        </script>-->
        
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
                                        <xsl:if test="$debugging">
                                            <xsl:attribute name="SECTION">3</xsl:attribute>
                                        </xsl:if>
                                        <xsl:apply-templates select="." mode="reveal-slide-attributes"/>
                                        <!--<xsl:copy-of select="
                                            @data-auto-animate
                                            | @data-auto-animate-duration
                                            | @data-auto-animate-easing
                                            | @data-auto-animate-unmatched
                                            | @data-background
                                            | @data-background-color
                                            | @data-background-gradient
                                            | @data-background-image
                                            | @data-background-size
                                            | @data-background-position
                                            | @data-background-repeat
                                            | @data-background-opacity
                                            | @data-transition
                                            | @data-background-video
                                            | @data-background-video-loop
                                            | @data-background-video-muted
                                            | @style
                                            "/>-->
                                        <!--<xsl:attribute name="test" select="'value'"/>-->
                                        <xsl:apply-templates mode="all-but-topicContainer"/>
                                    </section>
                                    <!-- For each subslide, copy to output but ignore sub-slides -->
                                    <xsl:for-each select=".//topicContainer">
                                        <section>
                                            <xsl:if test="$debugging">
                                                <xsl:attribute name="SECTION">4</xsl:attribute>
                                            </xsl:if>
                                            <xsl:apply-templates select="." mode="reveal-slide-attributes"/>
                                            <!-- This works -->
                                            <!--<xsl:copy-of select="
                                                @data-auto-animate
                                                | @data-auto-animate-duration
                                                | @data-auto-animate-easing
                                                | @data-auto-animate-unmatched
                                                | @data-background
                                                | @data-background-color
                                                | @data-background-gradient
                                                | @data-background-image
                                                | @data-background-size
                                                | @data-background-position
                                                | @data-background-repeat
                                                | @data-background-opacity
                                                | @data-transition
                                                | @data-background-video
                                                | @data-background-video-loop
                                                | @data-background-video-muted
                                                | @style
                                                "/>-->
                                            <xsl:apply-templates mode="all-but-topicContainer"/>
                                        </section>
                                    </xsl:for-each>
                                </xsl:variable>
                                <xsl:choose>
                                    <xsl:when test="$reveal.generate.vertical.slides = 'true'">
                                        <!-- Generate vertical slides, so wrap in a <section> element -->
                                        <section>
                                            <xsl:if test="$debugging">
                                                <xsl:attribute name="SECTION">5</xsl:attribute>
                                                <xsl:attribute name="ELEMENT-NAME"><xsl:value-of select="name()"/></xsl:attribute>
                                            </xsl:if>
                                            <xsl:if test="'topicContainer' != local-name()">
                                                <xsl:apply-templates select="." mode="reveal-slide-attributes"/>
                                            </xsl:if>
                                            <!--<xsl:copy-of select="
                                                @data-auto-animate
                                                | @data-auto-animate-duration
                                                | @data-auto-animate-easing
                                                | @data-auto-animate-unmatched
                                                | @data-background
                                                | @data-background-color
                                                | @data-background-gradient
                                                | @data-background-image
                                                | @data-background-size
                                                | @data-background-position
                                                | @data-background-repeat
                                                | @data-background-opacity
                                                | @data-transition
                                                | @data-background-video
                                                | @data-background-video-loop
                                                | @data-background-video-muted
                                                | @style
                                                "/>-->
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
                                    <xsl:if test="$debugging">
                                        <xsl:attribute name="SECTION">6</xsl:attribute>
                                        <xsl:attribute name="ELEMENT-NAME"><xsl:value-of select="local-name()"/></xsl:attribute>
                                        <xsl:attribute name="PARENT-ELEMENT-NAME"><xsl:value-of select="parent::*[1]/local-name()"/></xsl:attribute>
                                        <xsl:attribute name="FIRST-CHILD-ELEMENT-NAME"><xsl:value-of select="child::*[1]/local-name()"/></xsl:attribute>
                                    </xsl:if>
                                    <!-- This is not correct here. -->
                                    <!--<xsl:if test="local-name() != 'topicContainer'">
                                        <xsl:apply-templates select="." mode="reveal-slide-attributes"/>
                                    </xsl:if>-->
                                    <xsl:apply-templates select="." mode="reveal-slide-attributes"/>
                                    <!--<xsl:if test="@data-transition">
                                        <xsl:copy-of select="@data-transition"/>
                                    </xsl:if>-->
                                    <!--<xsl:copy-of select="
                                        @data-auto-animate
                                        | @data-auto-animate-duration
                                        | @data-auto-animate-easing
                                        | @data-auto-animate-unmatched
                                        | @data-background
                                        | @data-background-color
                                        | @data-background-gradient
                                        | @data-background-image
                                        | @data-background-size
                                        | @data-background-position
                                        | @data-background-repeat
                                        | @data-background-opacity
                                        | @data-transition
                                        | @data-background-video
                                        | @data-background-video-loop
                                        | @data-background-video-muted
                                        | @style
                                        "/>-->
                                    <xsl:apply-templates mode="all-but-topicContainer"/>
                                </section>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
                </div>
            </div>
            
            <script src="dist/reveal.js"></script>
            <script src="plugin/notes/notes.js"></script>
            <script src="plugin/markdown/markdown.js"></script>
            <script src="plugin/highlight/highlight.js"></script>
            
            <script>
                <!-- 
                    Full list of configuration options available here:
                    https://github.com/hakimel/reveal.js/blob/master/js/config.js
                -->
               
                // More info about initialization and config:
                // - https://revealjs.com/initialization/
                // - https://revealjs.com/config/
                Reveal.initialize({
                    <xsl:value-of select="if ($reveal.controls) then 'controls: ' || $reveal.controls || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.controlsTutorial) then 'controlsTutorial: ' || $reveal.controlsTutorial || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.controlsLayout) then 'controlsLayout: ''' || $reveal.controlsLayout || ''', ' else ''"/>
                    <xsl:value-of select="if ($reveal.controlsBackArrows) then 'controlsLayout: ''' || $reveal.controlsBackArrows || ''', ' else ''"/>
                    <xsl:value-of select="if ($reveal.hash) then 'hash: ' || $reveal.hash || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.respondToHashChanges) then 'respondToHashChanges: ' || $reveal.respondToHashChanges || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.height) then 'height: ' || $reveal.height || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.hideaddressbar) then 'hideAddressBar: ' || $reveal.hideaddressbar || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.jumpToSlide) then 'jumpToSlide: ' || $reveal.jumpToSlide || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.history) then 'history: ' || $reveal.history || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.keyboard) then 'keyboard: ' || $reveal.keyboard || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.keyboardCondition) then 'keyboardCondition: ''' || $reveal.keyboardCondition || ''', ' else ''"/>
                    <xsl:value-of select="if ($reveal.disableLayout) then 'disableLayout: ' || $reveal.disableLayout || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.overview) then 'overview: ' || $reveal.overview ||', ' else ''"/>
                    <xsl:value-of select="if ($reveal.center) then 'center: ' || $reveal.center || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.touch) then 'touch: ' || $reveal.touch || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.loop) then 'loop: ' || $reveal.loop || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.rtl) then 'rtl: ' || $reveal.rtl || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.navigationMode) then 'navigationMode: ''' || $reveal.navigationMode || ''', ' else ''"/>
                    <xsl:value-of select="if ($reveal.shuffle) then 'shuffle: ' || $reveal.shuffle || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.fragments) then 'fragments: ' || $reveal.fragments || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.fragmentInURL) then 'fragmentInURL: ' || $reveal.fragmentInURL || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.embedded) then 'embedded: ' || $reveal.embedded || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.help) then 'help: ' || $reveal.help || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.pause) then 'pause: ' || $reveal.pause || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.showNotes) then 'showNotes: ' || $reveal.showNotes || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.margin) then 'margin: ' || $reveal.margin || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.maxScale) then 'maxScale: ' || $reveal.maxScale || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.minScale) then 'minScale: ' || $reveal.minScale || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.mousewheel) then 'mouseWheel: ' || $reveal.mousewheel || ', ' else ''"/>
                    plugins: [ RevealMarkdown, RevealHighlight, RevealNotes ],
                    <xsl:value-of select="if ($reveal.previewlinks) then 'previewLinks: ' || $reveal.previewlinks || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.progress) then 'progress: ' || $reveal.progress || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.scrollProgress) then 'scrollProgress: ' || $reveal.scrollProgress || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.slidenumber) then 'slideNumber: ' || $reveal.slidenumber || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.showHiddenSlides) then 'showHiddenSlides: ' || $reveal.showHiddenSlides || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.autoPlayMedia) then 'autoPlayMedia: ' || $reveal.autoPlayMedia || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.preloadIframes) then 'preloadIframes: ' || $reveal.preloadIframes || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.autoAnimate) then 'autoAnimate: ' || $reveal.autoAnimate || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.autoAnimateMatcher) then 'autoAnimateMatcher: ' || $reveal.autoAnimateMatcher || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.autoAnimateEasing) then 'autoAnimateEasing: ''' || $reveal.autoAnimateEasing || ''', ' else ''"/>
                    <xsl:value-of select="if ($reveal.autoAnimateDuration) then 'autoAnimateDuration: ' || $reveal.autoAnimateDuration || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.autoAnimateUnmatched) then 'autoAnimateUnmatched: ' || $reveal.autoAnimateUnmatched || ', ' else ''"/>
                    autoAnimateStyles: ['opacity', 'color', 'background-color', 'padding', 'font-size', 'line-height', 'letter-spacing', 'border-width', 'border-color', 'border-radius', 'outline', 'outline-offset'],
                    <xsl:value-of select="if ($reveal.autoslide) then 'autoSlide: ' || $reveal.autoslide || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.autoslidestoppable) then 'autoSlideStoppable: ' || $reveal.autoslidestoppable || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.showSlideNumber) then 'showSlideNumber: ''' || $reveal.showSlideNumber || ''', ' else ''"/>
                    <xsl:value-of select="if ($reveal.hashOneBasedIndex) then 'hashOneBasedIndex: ' || $reveal.hashOneBasedIndex || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.transition) then 'transition: ''' || $reveal.transition || ''', ' else ''"/>
                    <xsl:value-of select="if ($reveal.transitionspeed) then 'transitionSpeed: ''' || $reveal.transitionspeed || ''', ' else ''"/>
                    <xsl:value-of select="if ($reveal.backgroundtransition) then 'backgroundTransition: ''' || $reveal.backgroundtransition || ''', ' else ''"/>
                    <xsl:value-of select="if ($reveal.view = 'null') then 'view: ' || $reveal.view || ', ' else if ($reveal.view = 'full' or $reveal.view = 'compact') then 'view: ''' || $reveal.view || ''', ' else ''"/>
                    <xsl:value-of select="if ($reveal.viewdistance) then 'viewDistance: ' || $reveal.viewdistance || ', ' else ''"/>
                    <xsl:value-of select="if ($reveal.width) then 'width: ' || $reveal.width || ', ' else ''"/>
                });
            </script>
        </body>
    </xsl:template>    
    
    <!--
        Process topics.
    -->
    <xsl:template match="*[contains(@class, ' topic/topic ')]|*[contains(@class, ' slide/slide ')]">
        <!-- Just a placeholder which will be replaced with <section> -->
        <topicContainer>
            <!--<xsl:if test="@data-transition">
                <xsl:copy-of select="@data-transition"/>
            </xsl:if>-->
            <!--<xsl:copy-of select="
                @data-auto-animate
                | @data-auto-animate-duration
                | @data-auto-animate-easing
                | @data-auto-animate-unmatched
                | @data-background
                | @data-background-color
                | @data-background-gradient
                | @data-background-image
                | @data-background-size
                | @data-background-position
                | @data-background-repeat
                | @data-background-opacity
                | @data-transition
                | @data-background-video
                | @data-background-video-loop
                | @data-background-video-muted
                | @style
                "/>-->
            <xsl:apply-templates select="." mode="reveal-slide-attributes"/>
            <xsl:apply-templates/>
        </topicContainer>
    </xsl:template>
    
    <xsl:template match="*" mode="reveal-slide-attributes">
        <xsl:copy-of select="
            @data-auto-animate
            | @data-auto-animate-duration
            | @data-auto-animate-easing
            | @data-auto-animate-unmatched
            | @data-background
            | @data-background-color
            | @data-background-gradient
            | @data-background-image
            | @data-background-size
            | @data-background-position
            | @data-background-repeat
            | @data-background-opacity
            | @data-background-video
            | @data-background-video-loop
            | @data-background-video-muted
            | @data-id
            | @data-line-numbers
            | @data-transition
            | @data-trim
            | @id
            | @style
            "/>
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
    <!--<xsl:template match="*[contains(@class,' pr-d/codeblock ')][contains(@outputclass, 'language-')]">
        <pre>
            <code>
                <xsl:attribute name="class">hljs <xsl:value-of select="substring-after(@outputclass,'language-')"/></xsl:attribute>
                <xsl:apply-templates/>
            </code>
        </pre>
    </xsl:template>-->
    
    <!-- Process slides - Override template from dita2xhtml-util.xsl -->
    <xsl:template match="nav | section | figure | article" mode="add-xhtml-ns" priority="20">
        <section>
            <xsl:if test="$debugging">
                <xsl:attribute name="SECTION">1</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="." mode="reveal-slide-attributes"/>
            <xsl:apply-templates select="@* except @role | node()" mode="add-xhtml-ns"/>
        </section>
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
            <xsl:if test="$debugging">
                <xsl:attribute name="SECTION">2</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
            <xsl:apply-templates select="*[not(contains(@class, ' topic/title '))] | text() | comment() | processing-instruction()"/>
            <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
        </div>
    </xsl:template>
    
    <!-- Deep copy template -->
    <xsl:template match="* | text() | @*" mode="all-but-topicContainer">
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
    <!--<xsl:template match="*|text()|@*" mode="all-but-topicContainer">
        <xsl:if test="'topicContainer' != local-name()">
            <xsl:copy>
                <xsl:apply-templates mode="all-but-topicContainer" select="node() | @*"/>
                <!-\-<xsl:apply-templates mode="all-but-topicContainer" select="@*"/>-\->
                <!-\-<xsl:apply-templates mode="all-but-topicContainer"/>-\->
            </xsl:copy>
        </xsl:if>
    </xsl:template>-->
    
    <!-- Speaker notes -->
    <xsl:template match="*[contains(@class, ' topic/div ')][contains(@outputclass, 'notes')]|*[contains(@class, ' slide/speakernotes ')]">
        <aside class="notes">
            <xsl:apply-templates/>
        </aside>
    </xsl:template>
    
    <!-- reveal.js fragment elements -->
    <!--<xsl:template match="*[contains(@class, ' topic/p ')]" name="topic.p">
        <xsl:choose>
            <xsl:when test="descendant::*[dita-ot:is-block(.)]">
                <div class="p">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:call-template name="setid"/>
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:if test="@type">
                        <xsl:attribute name="class" select="@class || @outputclass || 'fragment ' || @type"/>
                    </xsl:if>
                    <xsl:if test="@data-fragment-index">
                        <xsl:attribute name="data-fragment-index" select="@data-fragment-index"/>
                    </xsl:if>
                    <xsl:call-template name="commonattributes"/>
                    <xsl:call-template name="setid"/>
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>-->
    
    <xsl:template match="*[contains(@class, ' slide/slide-div ')]">
        <div>
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates select="." mode="reveal-slide-attributes"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' slide/slide-pre ')]">
        <pre>
            <xsl:apply-templates select="." mode="reveal-slide-attributes"/>
            <xsl:apply-templates/>
        </pre>
    </xsl:template>
    
    <!--<xsl:template match="*[contains(@class, ' slide/slide-image ')]">
        <img src="{@href}">
            <xsl:copy-of select="@style"/>
            <xsl:apply-templates/>
        </img>
    </xsl:template>-->
    
    <xsl:template name="topic-image">
        <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
        <img>
            <xsl:apply-templates select="." mode="reveal-slide-attributes"/>
            <xsl:call-template name="commonattributes">
                <xsl:with-param name="default-output-class">
                    <xsl:if test="@placement = 'break'"><!--Align only works for break-->
                        <xsl:choose>
                            <xsl:when test="@align = 'left'">imageleft</xsl:when>
                            <xsl:when test="@align = 'right'">imageright</xsl:when>
                            <xsl:when test="@align = 'center'">imagecenter</xsl:when>
                        </xsl:choose>
                    </xsl:if>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="setid"/>
            <xsl:choose>
                <xsl:when test="*[contains(@class, ' topic/longdescref ')]">
                    <xsl:apply-templates select="*[contains(@class, ' topic/longdescref ')]"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="@longdescref"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="@href|@height|@width"/>
            <xsl:apply-templates select="@scale"/>
            <xsl:choose>
                <xsl:when test="*[contains(@class, ' topic/alt ')]">
                    <xsl:variable name="alt-content"><xsl:apply-templates select="*[contains(@class, ' topic/alt ')]" mode="text-only"/></xsl:variable>
                    <xsl:attribute name="alt" select="normalize-space($alt-content)"/>
                </xsl:when>
                <xsl:when test="@alt">
                    <xsl:attribute name="alt" select="@alt"/>
                </xsl:when>
            </xsl:choose>
        </img>
        <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' slide/slide-p ')]">
        <p>
            <xsl:apply-templates select="." mode="reveal-slide-attributes"/>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!--<xsl:template match="*[contains(@class,' pr-d/codeblock ')][contains(@outputclass, 'language-')]">
        <pre>
            <code>
                <xsl:attribute name="class">hljs <xsl:value-of select="substring-after(@outputclass,'language-')"/></xsl:attribute>
                <xsl:apply-templates/>
            </code>
        </pre>
    </xsl:template>-->
    <xsl:template match="*[contains(@class, ' slide/slide-codeblock ')]">
        <code>
            <xsl:copy-of select="
                @data-trim
                | @data-line-numbers
                "/>
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </code>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' slide/slide ')]/*[contains(@class, ' slide/slide-title ')]">
        <xsl:param name="headinglevel" as="xs:integer">
            <xsl:choose>
                <xsl:when test="count(ancestor::*[contains(@class, ' topic/topic ')]) > 6">6</xsl:when>
                <xsl:otherwise><xsl:sequence select="count(ancestor::*[contains(@class, ' topic/topic ')])"/></xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:element name="h{$headinglevel}">
            <xsl:attribute name="class" select="concat('topictitle', $headinglevel)"/>
            <xsl:apply-templates select="." mode="reveal-slide-attributes"/>
            <xsl:call-template name="commonattributes">
                <xsl:with-param name="default-output-class">topictitle<xsl:value-of select="$headinglevel"/></xsl:with-param>
            </xsl:call-template>
            <xsl:attribute name="id"><xsl:apply-templates select="." mode="return-aria-label-id"/></xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!--<xsl:template match="*[contains(@class, ' slide/slide-p ')]" name="topic.p">-->
    <xsl:template match="*[contains(@class, ' slide/slide-h1 ')]">
        <h1>
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="setid"/>
            <xsl:apply-templates select="." mode="reveal-slide-attributes"/>
            <xsl:apply-templates/>
        </h1>
    </xsl:template>
    <xsl:template match="*[contains(@class, ' slide/slide-h2 ')]">
        <h2>
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="setid"/>
            <xsl:apply-templates select="." mode="reveal-slide-attributes"/>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    <xsl:template match="*[contains(@class, ' slide/slide-h3 ')]">
        <h3>
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="setid"/>
            <xsl:apply-templates select="." mode="reveal-slide-attributes"/>
            <xsl:apply-templates/>
        </h3>
    </xsl:template>
    
    <!--<xsl:template match="@data-transition" mode="reveal-slide-attributes">
        <xsl:value-of select="."/>
    </xsl:template>-->
    
</xsl:stylesheet>
