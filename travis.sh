#!/bin/sh
zip -r org.doctales.reveal.zip . -x *.zip* *.git/* *temp/* *out/*
curl -LO https://github.com/dita-ot/dita-ot/releases/download/2.3.2/dita-ot-2.3.2.zip
unzip -q dita-ot-2.3.2.zip
chmod +x dita-ot-2.3.2/bin/dita
dita-ot-2.3.2/bin/dita -install org.doctales.reveal.zip
dita-ot-2.3.2/bin/dita -input dita-ot-2.3.2/plugins/org.doctales.reveal/samples/reveal.ditamap -format termchecker-dita -verbose -Dprocessing-mode=strict -Dargs.language=en-GB -o out/termchecker-dita
dita-ot-2.3.2/bin/dita -input dita-ot-2.3.2/plugins/org.doctales.reveal/samples/reveal.ditamap -format termchecker-xliff -verbose -Dprocessing-mode=strict -Dargs.language=en-GB -o out/termchecker-xliff
dita-ot-2.3.2/bin/dita -input dita-ot-2.3.2/plugins/org.doctales.reveal/samples/reveal.ditamap -format tbx-basic -verbose -Dprocessing-mode=strict -o out/tbx-basic
dita-ot-2.3.2/bin/dita -input dita-ot-2.3.2/plugins/org.doctales.reveal/samples/reveal.ditamap -format tbx-min -verbose -Dprocessing-mode=strict -Dargs.source.language=en-GB -Dargs.target.language=de-DE -o out/tbx-min