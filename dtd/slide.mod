<!-- ================================================================================ -->
<!--  Refer to this file by the following public identifier or an 
      appropriate system identifier 
PUBLIC "-//DOCTALES//ELEMENTS DITA DOCTALES Slide//EN"
      Delivered as file "slide.mod"  -->
<!-- ================================================================================ -->

<!-- ================================================================================ -->
<!--                       SPECIALIZATION OF DECLARED ELEMENTS                        -->
<!-- ================================================================================ -->

<!ENTITY % slide-info-types 
  "slide
  "
>



<!-- ================================================================================ -->
<!--                              ELEMENT NAME ENTITIES                               -->
<!-- ================================================================================ -->

<!ENTITY % slide                 "slide"                                                >
<!ENTITY % slide-settings        "slide-settings"                                       >
<!ENTITY % background            "background"                                           >



<!-- ================================================================================ -->
<!--                              COMMON ATTLIST SETS                                 -->
<!-- ================================================================================ -->



<!-- ================================================================================ -->
<!--                            DOMAINS ATTRIBUTE OVERRIDE                            -->
<!-- ================================================================================ -->

<!ENTITY % included-domains         ""                                                  >



<!-- ================================================================================ -->
<!--                               ELEMENT DECLARATIONS                               -->
<!-- ================================================================================ -->

<!--                                 LONG NAME: Slide                                 -->

<!ENTITY % slide.content            "((%title;),
                                      (%slide-settings;)?,
                                      (%body;)?,
                                      (%slide-info-types;)*)
                                    ">
<!ENTITY % slide.attributes         "id   NMTOKEN   #REQUIRED
                                     %conref-atts; 
                                     %localization-atts;
                                     base   CDATA   #IMPLIED
                                     %base-attribute-extensions;
                                     outputclass   CDATA   #IMPLIED
                                     data-background   CDATA   #IMPLIED
                                     data-background-size   CDATA   #IMPLIED
                                     data-background-repeat   CDATA   #IMPLIED
                                     data-background-video   CDATA   #IMPLIED
                                     data-background-video-loop   CDATA   #IMPLIED
                                     data-background-iframe   CDATA   #IMPLIED
                                     data-transition   CDATA   #IMPLIED
                                     data-transition-speed   CDATA   #IMPLIED
                                    ">
<!--doc:The <slide> element is the root element of a slide topic. A slide represents a slide of a presentation.
Category: Slide elements-->
<!ELEMENT slide                      %slide.content;>
<!ATTLIST slide                      %slide.attributes;
                                     %arch-atts;
                                     domains CDATA "&included-domains;">


<!--                                 LONG NAME: Slide Settings                        -->

<!ENTITY % slide-settings.content  "((%background;)?)
                                    ">
<!--doc:The <slide-settings> element is a container for various slide specific settings.
Category: Slide elements-->
<!ELEMENT slide-settings             %slide-settings.content;>
<!ATTLIST slide-settings             %prolog.attributes;>


<!--                                 LONG NAME: Background                            -->

<!ENTITY % background.content       "EMPTY
                                    ">
<!ENTITY % background.attributes    "color   CDATA   #IMPLIED
                                     transition-in   (none|fade|slide|convex|concave|zoom)   'none'
                                     transition-out   (none|fade|slide|convex|concave|zoom)   'none'
                                     %data-element-atts;">

<!--doc:The <slide> element is the root element of a slide topic. A slide represents a slide of a presentation.
Category: Slide elements-->
<!ELEMENT  background %background.content;>
<!ATTLIST  background %background.attributes;>


<!-- ================================================================================ -->
<!--                      SPECIALIZATION ATTRIBUTE DECLARATIONS                       -->
<!-- ================================================================================ -->

<!ATTLIST slide          %global-atts; class CDATA "- topic/topic slide/slide ">
<!ATTLIST slide-settings %global-atts; class CDATA "- topic/prolog slide/slide-settings ">
<!ATTLIST background     %global-atts; class CDATA "- topic/data slide/background ">

<!-- ================================= End of file ================================== -->
