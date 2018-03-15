# Trailhead Force Leader Board : Track Trailhead Badges and Certifications
<a href="https://githubsfdeploy.herokuapp.com?owner=vishnuvaishnav&repo=Trailhead_ForceLeaderBoard">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>
<br/>
Steps to folloe after Deploying project in salesforce org:

1. Add these 2 Remote Site Settings:
	a. https://trailhead.salesforce.com
	b. http://certification.salesforce.com

2. Give Object and Fields permission to these 2 custom objects:
	a. Certification__c
	b. User__c

3. Run the scheduler to refresh data from trailhead:
	Go to Developer Console --> Open Execute Anonymous Window
	Here run this code:
	Utility.startUpdateDataBatch(10); //Where 10 is interval of schedule execution in minutes. You can modify it.

4. Create a Site:
	Now create a site and make available all pages to the site.

Ask your friends to Join the leaderboard.

Cheers!!