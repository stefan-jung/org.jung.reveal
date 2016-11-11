#!/bin/sh
zip -r org.doctales.reveal.zip . -x *.zip* *.git/* *temp/* *out/*
curl -LO https://github.com/dita-ot/dita-ot/releases/download/2.3.3/dita-ot-2.3.3.zip
unzip -q dita-ot-2.3.3.zip
mv dita-ot-*/ dita-ot/
chmod +x dita-ot/bin/dita
dita-ot/bin/dita -install org.doctales.reveal.zip
dita-ot/bin/dita -input dita-ot/plugins/org.dactales.reveal/samples/doctales.ditamap -format reveal -verbose -Dargs.reveal.css="dita-ot/plugins/org.dactales.reveal/css/doctales.css" -Dargs.reveal.theme="doctales"