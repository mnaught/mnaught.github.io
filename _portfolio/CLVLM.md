---
title: "Vehicle Lifecyle Management app"
excerpt: "Chain Enterprise/Mobile System tracking cars from arrival at a retail lot to crushed masses of steel on a flatbed.  With frickin' lasers."
header:
  
  teaser: /assets/folio/cl/contractPanel.png
sidebar:
  - title: "Role"
    image: /assets/folio/cl/contractPanel.png
    image_alt: "logo"
    text: "Software Engineer"  
  - title: "Tech"    
    text: "Web service/api, Asp.Net, Windows Mobile, SqlServer, Powershell, app integration"   
gallery:
  - image_path: assets/folio/csg/truck.jpg
    alt: "truck on lot"
  - image_path: assets/folio/csg/truckbarcode 1.jpg
    alt: "placeholder image 2"
  - image_path: assets/folio/csg/BarcodeCloseUp.jpg
    alt: "placeholder image 3"
---

## The Situation 

A large metal recycling company had acquired a national retail chain of auto salvage yards.

One of their objectives was to improve tracking of assets (cars) from arrival on the lot and through the workflow.  They wanted to do this consistently at each location, and use barcode tags to be able to automatically determine quite a bit of information about each asset in the workflow.

They had started tagging vehicles with barcodes, which looks like this:

{% include gallery caption="Early tags were placed outside which didn't weather well.  Eventually the barcode was attached inside the vehicle." %}

... And assigned a point person, a very capable Business Systems Analyst and very awesome person named Liz. 

Liz the BSA looks like this when holding a CK3 mobile device:

![A BSA in her natural habitat.  This one has an Intermec CK3 device, very rare at the time.](/assets/folio/csg/lizBSA.jpg)

They hired me to write a software system which would enable lot emsployees at retail locations to update the enterprise data systems as the asset moves through the workflow to eventual crushing & smelting into raw steel.

Liz had identified that they wanted to do that using Intermec's CK3 mobile devices, which look like this:

![Intermek ck3 devices](/assets/folio/csg/intermecck3s.jpg)

These are some very capable, rugged little devices running windows mobile (Well, it was called WinCE at the time, but was renamed windows mobile soon after this solution was developed.)   

These devices are basically everything you get from a smartphone today and incorporating a whole suite of more field oriented I/O options including RFID,  network connectivity and decent-powered laser barcode readers.
[CK3 User manual](/assets/folio/csg/CK3-pp-web.pdf)

## Solution path

Working with the client BSA, I designed and implemented the following artifacts installed into the customers environment:

* a Windows Mobile App (C#/Winforms) (WinCE)
* 2 web services
one for POSTed data from CK3s, one for I/O to the VIM Decode system
* 2 PowerShell scripts driven from AppScheduler
* Backing sprocs, data models

The Basic system context can be seen below.  The tan components in the diagram show the system I developed for this integration project.

![](/assets/folio/csg/VLM Deployment Diagram.jpg)

## Burndown 
I would have liked to have done more on this, with a web application for admin of activity, and a more robust host like a windows service but this fit what the client had for budget and timeline.

## Tech Talk
{: .notice--info}

## Integrating a 16-bit exe
One of the challenges here was there was the integration of an existing a VIN decode component. 

Processing needed to break the vehicle id number (VIN) associated with the asset into actual usable data about the car, things like make, model,color.... this was a process we named "VIN Decode".

For this the customer relied on a rather old 16 bit application that was kind of a niche product.  The vendor had gone out of business, there was no source, so all I could work with was the executable.  (blue box in the diagram) It had a batch interface mode.  

Based on existing infrastructure we decided to implement refresh off of an AppScheduler job running a powershell script, which I wrote to shell out to the VIN decode as part of it's regular process flow.

The actual dataflow from the CK3 mobile devices came from one of the web services, which posted into a couple of datastores, as well as updated device cache with lists and label values.

A separate task handled regular processing of uploaded data, pushing it into various enterprise stores and generating & emailing out reports. 

## "Store and forward"
Another challenge was that while the devices had wifi capability, the client had a constraint that they could not guarantee connectivity coverage everywhere on the lot where the devices needed to be used.

So, one hard design req they handed to me was that update from the retail locations would be driven off of a cradle operation instead of using a wifi connection.  

![You've seen these in grocery stores, delivery drivers.  Very nice little computer and developing for them is not much different than developing any other mobile app.](/assets/folio/csg/Intermecck3s 2.jpg)


