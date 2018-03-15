# (Create Your Personal Leader Board in 10 Minutes) ForceLeaderBoard - Track Trailhead Badges and Certifications
Click on this Magic button to Get Your Own LeaderBoard
<a href="https://githubsfdeploy.herokuapp.com?owner=vishnuvaishnav&repo=Trailhead_ForceLeaderBoard">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>
<br/>
Steps to follow after Deploying project in salesforce org:

1. Add these 2 Remote Site Settings:
	<br/>
	a. https://trailhead.salesforce.com
	<br/>
	b. http://certification.salesforce.com

2. Give permission Object and Fields for these 2 custom objects:
	<br/>
	a. Certification__c
	<br/>
	b. User__c

3. Run the scheduler to refresh data from trailhead and certification:
	<br/>
	Go to Developer Console --> Open Execute Anonymous Window
	<br/>
	Here run this code:
	<br/>
	Utility.startUpdateDataBatch(10); 
	<br/>
	//Where 10 is interval of schedule execution in minutes. You can modify it.

4. Create a Site:
	Now create a public site and give permission to all pages and classes.

<br/>
Ask your friends and colleague to Join the your personal leaderboard.
<br/>

Cheers!!

<br/>
Please hit below button for any suggestions and feedback.
<a href="https://0to1code.wordpress.com/contact/">
  <img alt="Feedback"
       src="http://bourbonstreetshots.com/wp-content/uploads/2014/01/tumblr_m73mpnaKdX1qb1v08.jpg">
</a>
