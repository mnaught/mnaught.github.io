---
title: "HB/Pilot Qualifications Module"
excerpt: "Enterprise system for pilot crew and staff quals"
header:
  image: /assets/images/foo-bar-identity.jpg
  teaser: /assets/images/foo-bar-identity-th.jpg
sidebar:
  - title: "Role"
    image: http://placehold.it/350x250
    image_alt: "logo"
    text: "Software Engineer, Front-End& Backend & Messaging systems"
gallery:
  - url: /assets/images/unsplash-gallery-image-1.jpg
    image_path: assets/images/unsplash-gallery-image-1-th.jpg
    alt: "placeholder image 1"
  - url: /assets/images/unsplash-gallery-image-2.jpg
    image_path: assets/images/unsplash-gallery-image-2-th.jpg
    alt: "placeholder image 2"
  - url: /assets/images/unsplash-gallery-image-3.jpg
    image_path: assets/images/unsplash-gallery-image-3-th.jpg
    alt: "placeholder image 3"
---


The Company: Columbia Helicopters.

The lines of business included Defense (DoD), Oil and Gas Exploration, Forestry, Fire service, Construction, field and stream jobs, and pretty much anything requiring a big capable dual rotor helicopter.

When I worked there, the company operated in Peru, Papua New Guinea, the United States and Afghanistan.

The Situation: 

Compliance audits were a frequent reality.  Auditors could show up and negative findings had the potential to have millions of dollars of impact.
  
The main way of record keeping was spreadsheets, printouts, and file cabinet after file cabinet of paper.  

Staff were drowning in data.
  
  Record-keeping had to deal with out of date information, communications, trapping their objective evidence that they had met the qualifications requirements.  They neede a way of managing pilot data and audit response that was accurate, thorough and repeatable.

 The System:  The pilot quals module featured:
 <ul>
 <li>Events Editor</li>
 <li>Qualification Track editor</li>
 <li>Rules Engine and rules editor.</li>
 
 <li>Instant detection and subscription-based notification of events which affect a persons "standing" in a qualification track. </li>
</ul>

What worked well: Staying Generic.  The business could change, a new country could become a new area of operations, regulatatory change, a new or different line of business.  Most off all, what a "requirement" was could change at any day.  

My judgement was tha domain-based approaches here would be brittle
Each new wrinkle being introduced over time had the potential to increase complexity, leading to problems responding to new business requirements.

So, my data models for the problem had to be extremely flexible.
Users, not IT staff, needed to be able to modify the standards now being applied automatically to everyone in the company.


All of this argued for:
a flexible modeling of the ideas of "Qualification Tracks" "events" 
a way to attach rules to interpret what effect an event has on a pilot's 
No doubt in my mind.  

 
 The Effect:  The system was so successful in meeting the operational requirement so the flight ops staff that it was expanded to 


TechNotes: ASP.Net MVC, SignalR, Windows services.

 
{% include gallery caption="This is a sample gallery to go along with this case study." %}



