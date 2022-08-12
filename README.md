org.doctales.reveal
===========================

![DOCTALES Logo](https://doctales.github.io/images/doctales-logo-without-subtitle.svg)

[![DITA-OT 3.7](https://img.shields.io/badge/DITA--OT-3.7-blue.svg)](http://www.dita-ot.org/3.7)
[![Build Status](https://travis-ci.org/doctales/org.doctales.reveal.svg?branch=master)](https://travis-ci.org/doctales/org.doctales.reveal)
[![license](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0)

This is a plugin for the DITA-OT. The plugin adds a new transtype called `reveal` for transforming DITA maps into [reveal.js](https://revealjs.com/#/) based web presentations.

![Sample Presentation](https://raw.githubusercontent.com/doctales/doctales.github.io/master/media/animations/reveal-sample-presentation.gif)


## Installation

1. Move to the `~/bin` directory of the DITA-OT.
2. Install the plugin using the `dita` command.  
   `dita --install https://github.com/doctales/org.doctales.reveal/archive/master.zip`
   
Note: For the plugin to work in some environments, such as oXygenXML, you may need to add  `org.doctales.reveal\framework` as an additional frameworks directory. In oXygenXML, Options > Preferences > Document Type Association > Locations. This provides the schemas to create the `Slide` topic type and for proper transformation from within oXygenXML. 

## Using the Plugin

Please refer to the [documentation](https://doctales.atlassian.net/wiki/x/LIAy).
