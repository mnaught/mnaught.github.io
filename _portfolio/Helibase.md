---
title: "Helibase Portal "
excerpt: "A loosly coupled, distributed software solution for a 50+ year old heavy-lift helicopter company."
header:
  image: /assets/folio/chi/chi2015Group.jpg
  teaser: /assets/folio/chi/chi2015Group.jpg
sidebar:
  - title: "Role"
    image: assets/folio/chi/chiwtlogo280px.png
    image_alt: "logo"
    text: "Software Developer, Flight Operations Group"  
gallery:
  - url: /assets/folio/chi/hbMain.jpg
    image_path: /assets/folio/chi/hbMain.jpg
    alt: "HB/Main"
  - url: /assets/folio/chi/HBQualsDashboard.jpg
    image_path: /assets/folio/chi/HBQualsDashboard.jpg
    alt: "HB/Quals"
  - url: /assets/folio/chi/HBWQualsNotif.jpg
    image_path: /assets/folio/chi/HBWQualsNotif.jpg 
    alt: "HB/Notification"
---
Note: This Use Case documents the user-facing web portal.  Other use cases in the Portfolio describe different aspects of the overall system.  Related use cases are named with the prefix "HB/"

## The Situation 

The flight operations group at this company had to manage and produce a lot data.

When they interviewed me for a software developer position, they demonstrated an iPad application they had written. 

The app was planned to be used by the copilot on each and every job flown.  The app accumulated a rich collection of production data as copilots used it on various jobs each day.   

With 23  aircraft operating every day, they needed this data to flow off of the devices and into a form that would inform daily operational decisions.

It was one of many iPad apps they had planned.   They were enamoured with the cost and capability of the iPad compared to the $10k/unit ruggedized windows tablets they had been using.

The challenge: Integrate the data they were collecting so that people can use it.

After the meeting, I was so certain that I knew what they needed that I went home, and sketched out what become the overall design of the system.

### When hired, I hit the ground running.

I worked for the company for almost five years.  In that time, I built off of this very flexible framework and developed a number of additional systems automating many more critical processes for the company.

The system was so successful that they rolled it out the entire company worldwide.  

The message-based service bus architecture proved out.  
Home Run.


## Solution path
{% include gallery caption="While presented conceptually to the users as a single application, the portal is actually a collection of subsystems sitting on a service bus.  Here are a few screens from the quals subsystem." %}

Helibase Portal:
* User Portal presenting and securing all system features by user/group.

Portal Features:

Subsystems: Portal provides user acess for these subsystems 
(I developed these too.)

* HB/Quals 
* HB/Flight Release
* HB/Risk Assessment
* HB/Check and Training
* HB/Risk management
* HB/Qualifications
* HB/Flight and Duty

Admin Features
* User account admin / permissions editor
* Message monitoring and alerting
* Emergency Response Plan upload
* Reports


## Burndown / Debrief

I did a lot of work to establish with stakeholders some funny ideas about how to develop software.

I explained version numbers, sprints, requirements backlogs, and proposed a way of working based off of something called SCRUM.

I installed MS Team Foundation Server and explained it.  I evangelized TFS to IT group, and explained why these kinds of collaborative systems are an improvement over SourceSafe, which they were using in 2013 for source control.   

I showed them the different templates for workflow, and explained the workflow I used and how it supports iterative refinement of what we build.  

I was fortunate in that management and the IT group were open to some of these ideas.  

The funny ideas paid off as stakeholders saw that features were being added incrementally and predictably.  Further, the features were solving the problems they intended to solve and they were doing it consistently and reliably.

Using this agile-inspired process, and some improved (dare I say "standard") software development process, I designed and built a number of systems for this group in 2 to 3 week sprints over the next five years.  



