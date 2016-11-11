![DOCTALES Logo](https://doctales.github.io/images/doctales-logo-without-subtitle.svg)

- - - -

org.doctales.reveal
===========================

[![Build Status](https://travis-ci.org/doctales/org.doctales.reveal.svg?branch=master)](https://travis-ci.org/doctales/org.doctales.reveal)
[![license](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0)

This is a plugin for the DITA-OT. The plugin adds a new transtype called `reveal` for transforming DITA maps into reveal.js based web presentations.


## Installation

1. Move to the `~/bin` directory of the DITA-OT.
2. Install the plugin using the `dita` command.  
   `dita -install https://github.com/doctales/org.doctales.reveal/archive/master.zip`


## Publishing a presentation

Before creating your first presentation, you should publish the sample presentation, that is being shipped with the plugin. From the plugin directory, call the `dita` command and pass the parameter `args.reveal.css` and point it to the DOCTALES CSS and set the parameter `args.reveal.theme` to `doctales` to activate the stylesheet.

```bash
dita -i samples/doctales.ditamap -f reveal -Dargs.reveal.css="css/doctales.css" -Dargs.reveal.theme="doctales"
```

![Sample Presentation](https://raw.githubusercontent.com/doctales/doctales.github.io/master/media/animations/reveal-sample-presentation.gif)

Now the presentation should be published to the `~/out` directory.


## Create a presentation

Creating a presentation is easy. A DITA topic represents a single slide. The DITA Map holds all topics/slides together. Take a look at the `~/samples/doctales.ditamap`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE map PUBLIC "-//OASIS//DTD DITA Map//EN" "map.dtd">
<map>
 <title>DOCTALES</title>
 <topicref href="topics/01_title.dita"/>
 <topicref href="topics/02_DOCTALES.dita"/>
</map>
```

The map contains references two to topics, each representing a top-level slide. The first topic contains the title and the logo.

**01_title.dita**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE topic PUBLIC "-//OASIS//DTD DITA Topic//EN" "topic.dtd">
<topic id="title">
  <title>DOCTALES</title>
  <body>
    <fig>
      <image placement="break" href="https://doctales.github.io/images/doctales-logo.svg">
        <alt>DOCTALES Logo</alt>
      </image>
    </fig>
  </body>
</topic>
```

The second slide contains a title and nested topics, that are rendered as horizontal slides.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE topic PUBLIC "-//OASIS//DTD DITA Topic//EN" "topic.dtd">
<topic id="doctales">
  <title>DOCTALES</title>
  <!-- First horizontal slide -->
  <topic id="who-are-we">
    <title>Who are we</title>
    <body>
      <p>We are a small team of technical writers with the vision of making DITA easier to use for small teams.</p>
      <ul>
        <li>Stefan Eike</li>
        <li>Sascha Nothofer</li>
      </ul>
    </body>
  </topic>
  <!-- Second horizontal slide -->
  <topic id="plugins">
    <title>What we are doing</title>
    <body>
      <ul>
        <li>We are developing <xref href="https://doctales.github.io/plugins/Plugins.html" format="html" scope="external">plugins</xref> for the DITA-OT for various use cases.</li>
      </ul>
    </body>
  </topic>
  <!-- Third horizontal slide -->
  <topic id="support">
    <title>Support</title>
    <body>
      <ul>
        <li>If you want to join and support us, write an e-mail to <xref href="mailto:stefan.eike@mailbox.org" format="html" scope="external">stefan.eike@mailbox.org</xref>.</li>
        <li>If you need help with one of our plugins, write <xref href="http://stackoverflow.com/" format="html" scope="external">Stackoverflow topic</xref> and label it with <i>DITA</i> and <i>DOCTALES</i>.</li>
        <li>If you have found a bug, please raise an issue on <xref href="http://github.com/doctales/" format="html" scope="external">Github</xref>.</li>
      </ul>
    </body>
  </topic>
</topic>
```


## Parameters

The following Ant target shows all curre
Create a new target in your Ant build file. The following target shows all currently supported parameters of the plugin. You do not have to set the optional parameters, if you feel comfortable with the default settings.

```xml
<?xml version="1.0" encoding="UTF-8"?>

<target name="reveal" description="Generate a reveal.js based web presentation.">
    <ant antfile="${dita.dir}\build.xml">
        <!-- The input DITA map. -->
        <property name="args.input" value="[YOURMAP].ditamap"/>
        
        <!-- The output directory. -->
        <property name="output.dir" value="out/reveal"/>
        
        <!-- The transformation type. -->
        <property name="transtype" value="reveal"/>
        
        
        <!-- OPTIONAL PROPERTIES -->
        
        <!-- Path to custom template file -->
        <property name="args.reveal.css" value="my-template.css"/>
        
        <!--
            The template. Possible values:
            "default", "sky", "beige", "simple",
            "serif", "night", "moon", "solarized"
            If you use a custom template, the name
            of the template is the filename without its
            extensions, e.g. "my-template"
        -->
        <property name="args.reveal.theme" value="default"/>
        
        <!-- Display controls in the bottom right corner. -->
        <property name="args.reveal.controls" value="true"/>
        
        <!-- Display a presentation progress bar. -->
        <property name="args.reveal.progress" value="true"/>
        
        <!-- Display the page number of the current slide. -->
        <property name="args.reveal.slidenumber" value="false"/>
        
        <!-- Push each slide change to the browser history. -->
        <property name="args.reveal.history" value="false"/>
        
        <!-- Enable keyboard shortcuts for navigation. -->
        <property name="args.reveal.keyboard" value="true"/>
        
        <!-- Enable the slide overview mode. -->
        <property name="args.reveal.overview" value="true"/>
        
        <!-- Enable the vertical centering of slides. -->
        <property name="args.reveal.center" value="true"/>
        
        <!-- Enable touch navigation on devices with touch input. -->
        <property name="args.reveal.touch" value="true"/>
        
        <!-- Loop the presentation. -->
        <property name="args.reveal.loop" value="false"/>
        
        <!-- Change the presentation direction to be right-to-left. -->
        <property name="args.reveal.rtl" value="false"/>
        
        <!-- Turn fragments on and off globally. -->
        <property name="args.reveal.fragments" value="true"/>
        
        <!--
            Flags if the presentation is running in an embedded mode,
            i.e. contained within a limited portion of the screen.
        -->
        <property name="args.reveal.embedded" value="false"/>
        
        <!--
            Number of milliseconds between automatically proceeding to the
            next slide, disabled when set to 0, this value can be overwritten
            by using a data-autoslide attribute on your slides.
        -->
        <property name="args.reveal.autoslide" value="0"/>
        
        <!-- Stop auto-sliding after user input. -->
        <property name="args.reveal.autoslidestoppable" value="true"/>
        
        <!-- Enable slide navigation via mouse wheel. -->
        <property name="args.reveal.mousewheel" value="false"/>
        
        <!-- Hide the address bar on mobile devices. -->
        <property name="args.reveal.hideaddressbar" value="true"/>
        
        <!-- Open links in an iframe preview overlay. -->
        <property name="args.reveal.previewlinks" value="false"/>
        
        <!--
            Set the transition style. Possible values:
            "default", "cube", "page", "concave",
            "zoom", "linear", "fade", "none"
        -->
        <property name="args.reveal.transition" value="default"/>
        
        <!--
            Set the transition speed. Possible values:
            "default", "fast", "slow"
        -->
        <property name="args.reveal.transitionspeed" value="default"/>
        
        <!--
            Set the transition style for full page
            slide backgrounds. Possible values:
            "default", "none", "slide", "concave", "convex", "zoom"
        -->
        <property name="args.reveal.backgroundtransition" value="default"/>
        
        <!-- Set the number of slides away from the current that are visible. -->
        <property name="args.reveal.viewdistance" value="3"/>
        
        <!--
            Set the parallax background image.
            Example:
            "'https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg'"
        -->
        <property name="args.reveal.parallaxbackgroundimage" value=""/>
        
        <!--
            Set the parallax background size.
            Example:
            "2100px 900px"
        -->
        <property name="args.reveal.parallaxbackgroundsize" value=""/>
    </ant>
</target>
```

