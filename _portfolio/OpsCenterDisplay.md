---
title: "HB/Ops Center Display"
excerpt: "Ops Center large mode display subystem, HB/Quals"
header:
  image: /assets/folio/chi/OpsCenter.jpg
  teaser: assets/folio/chi/OpsCenter.jpg
sidebar:
  - title: "Role"
    image: assets/folio/chi/chiwtlogo280px.png
    image_alt: "logo"
    text: "Software Developer, Flight Operations Group"
gallery:
  - url:  /assets/folio/chi/HBQualsDashboard.jpg
    image_path: assets/folio/chi/HBQualsDashboard.jpg
    alt: "Regular Quals Dashboard"
  - url:  /assets/folio/chi/QualsCloseup.jpg
    image_path: assets/folio/chi/QualsCloseup.jpg
    alt: "Large Screen App launched."
  - url:  /assets/folio/chi/OpsOuterDisplays.jpg
    image_path: assets/folio/chi/OpsOuterDisplays.jpg
    alt: "placeholder image 3"
---
## The Situation 

Management wanted to surface key status indicators from our personnel qualifications system (another system I developed) in the new Operations Center. This would provide decision support to staff serving field and air crew and had a direct impact on safety and operational efficiency.

 The quals subsystem I developed was built around the individual PC user, sitting at a desks at a screen.  But when the Ops Center started being designed, we quickly realized that the existing application would need to be expanded somehow to reach a wider "audience" in the Ops Center, and still permit some interactivity and configuration too.

 That was the funnest thing about this project, figuring out how to do that last thing.
 
 Required:
  * Big screen Ops Center display of data state of the HB/quals system
  * Instant update of information the second it hits other areas of the system.  
  * A way to permit staff to build their own dashboards
  * A solution which added value for all system users, not just the Ops Center.

{% include gallery caption="(Left picture) shows the admin screen in the quals subsystem I developed.  Good for admin staff ... NOT good for Ops Center screens!  (Center picture) shows the end result, a new big picture mode screen which is launched from the admin screen. (Right)  We ran this app alongside commercial SaaS in the OpsCenter 24x7" %}

## Solution path

Rather than go with a standalone app, I added a new feature to the  existing system (HB/Quals) which puts the application into a special large screen mode.  

Staff can see instantly the status of personnel in the field as logistics evolve and they need to make decisions.

The direct result doing it this way was it was a feature that every system user benefitted from.  They could use it in Peru on a desktop, or a large monitor in New Guinea and it would still update events in near real time.  (Given decent connectivity)

This was one of many systems I developed while working in this group.  Look for other items starting with HB/

## Burndown / Debrief

This was operational within one sprint of effort, and further refined over an additional two sprints as users had an artifact to work off of and generated new ideas and mod requests.

There were many opportunities to innovate at this company.  

New requirements became easy to address once the base platform framework was developed.

## Tech Talk
{: .notice--info}

 
 This is where the message-based design really paid off.
 
 All I had to do to implement the automatic updating feature was write an adapter taking messages off of the MassTransit bus and pushing them through a SignalR hub and also implement the javascript to update the display when new information was pushed.  
 
 SignalR is such a great toolkit.  It's an implementation of rpc style callbacks for  javascript functions.   
 
 Basically, this pattern lets the web page running on the users browser subscribe to certain events.  And when those events occur, the event triggers a javascript function running in the web browser, receiving data from that event.

 This app received events to update the status (color of the dot, presence of the dot) of each displayed user/track.  It also subscribed to another message type to handle crawler messages appearing at the bottom of the screen.

 For the most part, I just had to adapt to a few messages already occuring as part of the system's normal operation, and turn them into SignalR events.

System Features:
 * Looping display of tracks & membership status (pausable)
 * Crawler notifications 
 * Any actions taken in the other systems which affect the qualification status of a displayed user is immediately updated on any screen viewing this page.  This includes any web user in the world who has the page up on their browser.
 * Users can build their own dashboard to display by selecting tracks.

Tech: ASP.Net MVC, SignalR, javascript, jquery Windows services.
