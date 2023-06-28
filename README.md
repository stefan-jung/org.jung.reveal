org.jung.reveal
===============

[![DITA-OT 3.7](https://img.shields.io/badge/DITA--OT-3.7-blue.svg)](http://www.dita-ot.org/3.7)  
[![license](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0)

This is a plugin for the DITA-OT. The plugin adds a new transtype called `reveal` for transforming DITA maps into [reveal.js](https://revealjs.com/#/) based web presentations.


## Installation

Install the plugin with the `dita` command.

```bash
dita --install https://github.com/stefan-jung/org.jung.reveal/archive/master.zip
```
 
> **Note**: For the plugin to work in some environments, such as oXygenXML, you may need to add  `org.jung.reveal\framework` as an additional frameworks directory. In oXygenXML, Options > Preferences > Document Type Association > Locations. This provides the schemas to create the `Slide` topic type and for proper transformation from within oXygenXML. 

## Using the Plugin

Please refer to the documentation on [stefan-jung.org](https://stefanjung.netlify.app/plugins/reveal).
