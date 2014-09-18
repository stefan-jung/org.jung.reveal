<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output omit-xml-declaration="yes" indent="yes"/>
   
    <!-- Define a newline character -->
    <xsl:variable name="newline"><xsl:text>
</xsl:text></xsl:variable>
    
   
<!-- 
    This template overrides the template 'generateDefaultCopyright' defined in the 'dita2htmlimpl.xsl'.
    It injects multiple <meta> elements, some CSS and some JavaScript.
-->
<xsl:template name="generateDefaultCopyright">
<meta name="apple-mobile-web-app-capable" content="yes" />
<xsl:value-of select="$newline"/>
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<xsl:value-of select="$newline"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<xsl:value-of select="$newline"/>    
<link rel="stylesheet" href="css/reveal.min.css" />
<xsl:value-of select="$newline"/>
<link rel="stylesheet" href="css/theme/default.css" id="theme" />
<xsl:value-of select="$newline"/>
<!-- For syntax highlighting -->
<xsl:value-of select="$newline"/>
<link rel="stylesheet" href="lib/css/zenburn.css" />
<xsl:value-of select="$newline"/>
<!-- If the query includes 'print-pdf', include the PDF print sheet -->
<script>
if (window.location.search.match(/print-pdf/gi)) {
    var link = document.createElement( 'link' );
    link.rel = 'stylesheet';
    link.type = 'text/css';
    link.href = 'css/print/pdf.css';
    document.getElementsByTagName( 'head' )[0].appendChild( link );
}
</script>
<!--[if lt IE 9]>
    <xsl:value-of select="$newline"/>
	    <script src="lib/js/html5shiv.js"></script>
    <xsl:value-of select="$newline"/>
	<![endif]-->
<xsl:value-of select="$newline"/>
</xsl:template>
    
<!-- Override the 'generateCssLinks' template defined in the 'dita2htmlimpl.xsl' to get rid of the default XHTML CSS links. -->
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
        <div class="reveal">
            <!-- Any section element inside of this container is displayed as a slide -->
            <div class="slides">
                <!-- Already put xml:lang on <html>; do not copy to body with commonattributes -->
                <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]/@outputclass" mode="add-ditaval-style"/>
                <!--output parent or first "topic" tag's outputclass as class -->
                <xsl:if test="@outputclass">
                    <xsl:attribute name="class"><xsl:value-of select="@outputclass" /></xsl:attribute>
                </xsl:if>
                <xsl:if test="self::dita">
                    <xsl:if test="*[contains(@class, ' topic/topic ')][1]/@outputclass">
                        <xsl:attribute name="class"><xsl:value-of select="*[contains(@class, ' topic/topic ')][1]/@outputclass" /></xsl:attribute>
                    </xsl:if>
                </xsl:if>
                <xsl:apply-templates select="." mode="addAttributesToBody"/>
                <xsl:call-template name="setidaname"/>
                <xsl:value-of select="$newline"/>
                <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
                <xsl:call-template name="generateBreadcrumbs"/>
                <xsl:call-template name="gen-user-header"/>  <!-- include user's XSL running header here -->
                <xsl:call-template name="processHDR"/>
                <xsl:if test="$INDEXSHOW = 'yes'">
                <xsl:apply-templates select="/*/*[contains(@class, ' topic/prolog ')]/*[contains(@class, ' topic/metadata ')]/*[contains(@class, ' topic/keywords ')]/*[contains(@class, ' topic/indexterm ')] |
                /dita/*[1]/*[contains(@class, ' topic/prolog ')]/*[contains(@class, ' topic/metadata ')]/*[contains(@class, ' topic/keywords ')]/*[contains(@class, ' topic/indexterm ')]"/>
                </xsl:if>
                <!-- Include a user's XSL call here to generate a toc based on what's a child of topic -->
                <xsl:call-template name="gen-user-sidetoc"/>
                <xsl:apply-templates/> <!-- this will include all things within topic; therefore, -->
                <!-- title content will appear here by fall-through -->
                <!-- followed by prolog (but no fall-through is permitted for it) -->
                <!-- followed by body content, again by fall-through in document order -->
                <!-- followed by related links -->
                <!-- followed by child topics by fall-through -->
                
                <xsl:call-template name="gen-endnotes"/>    <!-- include footnote-endnotes -->
                <xsl:call-template name="gen-user-footer"/> <!-- include user's XSL running footer here -->
                <xsl:call-template name="processFTR"/>      <!-- Include XHTML footer, if specified -->
                <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
            </div>
        </div>
        
        <!--
            The <br/> tag is necessary to avoid that the <script> tag
            will be collapsed to its shortform: <script/>
            The collapsed <script> tag might not be correctly displayed
            in the browser.
        -->
        <script src="lib/js/head.min.js"><br/></script>
        <script src="js/reveal.min.js"><br/></script>
        <script>
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
    <xsl:value-of select="$newline"/>
</xsl:template>    

<!-- 
    This template overrides the corresponding template defined in the 'dita2htmlimpl.xsl'.
    It injects a <section> element.
-->
<xsl:template match="*[contains(@class, ' topic/topic ')]" mode="child.topic" name="child.topic">
    <section>
        <xsl:apply-templates/>
    </section>
    <xsl:value-of select="$newline"/>
</xsl:template>
    
</xsl:stylesheet>
