---
title: "Targeted Newsletter App"
excerpt: "This small web application I did in 2006 changed how I develop software."
header: 
  teaser: assets/folio/cl/intelLogo.jpg
sidebar:
  - title: "Role"
    image: /assets/folio/cl/contractPanel.png
    image_alt: "logo"
    text: "Code Labs Contract" 
  - title: "Tech"    
    text: "Asp.Net, Tibco Service bus" 
gallery:
  - url: /assets/folio/cl/IDEA_Screen_Main.bmp
    image_path: assets/folio/cl/IDEA_Screen_Main.bmp
    alt: "placeholder image 1"
  - url: /assets/folio/cl//IDEA_Screen_EditOffer.bmp
    image_path: assets/folio/cl/IDEA_Screen_EditOffer.bmp
    alt: "placeholder image 2"
  - url: /aassets/folio/cl/IDEA_Screen_AddNL.bmp
    image_path: assets/folio/cl/IDEA_Screen_AddNL.bmp
    alt: "placeholder image 3"
---

In 2006 Intel hired me to do a Data Quality Dashboard project for one of their Marketing groups.  

As often happens, there was some roadblock with the planning & they asked if I'd do this small web application in the meantime.

 
{% include gallery caption="A very basic user interface accepting spreadsheets for data input, preparing order files and dropping them on the ESB for delivery to a 3rd party vendor who handles the generation and sendout." %}

This small utility app enabled marketers to prepare datafiles for submission to a 3rd party vendor who did mass-email newsletter generation, targeting individual subscribers with customized content which matches their own interests. 

I include here because this project fundamentally changed how I approach software design for enterprise applications, as it was my first exposure to a real world ESB. 


{: .notice--info}
<div>
System Details:<br><br>

Inputs were a number of Excel spreadsheets containing recipient info, offers, and a few other items like taglines and text copy. <br><br>

Outputs were xml files and a bus message which initiated the newsletter vendor's pickup of the new output.  <br><br>
</div>