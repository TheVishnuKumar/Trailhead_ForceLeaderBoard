/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
public class APIExplorerController{
    
    public string trailblazerProfile_Id{get;set;}
    public string trailblazerProfileReqUrl_Show{get;set;}
    public string trailblazerProfileResponse{get;set;}
    
    public APIExplorerController(){
        trailblazerProfile_Id = '';
        trailblazerProfileReqUrl_Show = 'https://forceleaderboard-developer-edition.na50.force.com/services/apexrest/trailblazer?id=';
        trailblazerProfileResponse = '';
    }
    
    public void getTrailblazerProfile(){
        trailblazerProfileReqUrl_Show = 'https://forceleaderboard-developer-edition.na50.force.com/services/apexrest/trailblazer?id='+trailblazerProfile_Id;
        trailblazerProfileResponse = APIHelper.genericGetCall(trailblazerProfileReqUrl_Show).getBody();
    }
}