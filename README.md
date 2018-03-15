# (Create Your Personal Leader Board in 10 Minutes) ForceLeaderBoard - Track Trailhead Badges and Certifications
<a href="https://githubsfdeploy.herokuapp.com?owner=vishnuvaishnav&repo=Trailhead_ForceLeaderBoard">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>
<br/>
Steps to folloe after Deploying project in salesforce org:

1. Add these 2 Remote Site Settings:
	<br/>
	a. https://trailhead.salesforce.com
	<br/>
	b. http://certification.salesforce.com

2. Give Object and Fields permission to these 2 custom objects:
	<br/>
	a. Certification__c
	<br/>
	b. User__c

3. Run the scheduler to refresh data from trailhead:
	<br/>
	Go to Developer Console --> Open Execute Anonymous Window
	<br/>
	Here run this code:
	<br/>
	Utility.startUpdateDataBatch(10); 
	<br/>
	//Where 10 is interval of schedule execution in minutes. You can modify it.

4. Create a Site:
	Now create a site and make give permission to all pages.

<br/>
Ask your friends to Join the leaderboard.
<br/>

Cheers!!