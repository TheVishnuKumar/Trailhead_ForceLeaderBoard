/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
public class ManualRefresh{
    public ManualRefresh(ApexPages.StandardController controller){
        
    }
    
    public void init(){
        string userid = apexpages.currentpage().getparameters().get('id');
        user__c u = [select Name__c ,Title__c ,Profile_URL__c ,Badges__c ,Points__c ,
        Trailhead_URL__c ,Certification_URL__c ,Facebook__c ,Linkedin__c , Trailblazer_ID__c ,Twitter__c ,name, Rank__c  from user__c where id =: userid];
        UpdateDataHelper udp = new UpdateDataHelper(u);
    }
}