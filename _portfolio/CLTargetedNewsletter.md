---
title: "Targeted Newsletter App"
excerpt: "This small web application I did in 2006 changed how I develop software."
eader: 
  teaser: assets/folio/cl/intelLogo.jpg

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