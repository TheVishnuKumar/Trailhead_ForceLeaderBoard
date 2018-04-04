/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
public class Utility{

    public static String generateRandomString(Integer len) {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        while (randStr.length() < len) {
           Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
           randStr += chars.substring(idx, idx+1);
        }
        return randStr; 
    }
    
    //This will stop job
    public static void stopUpdateDataBatch(){
        list<CronTrigger> rountingEngineSchedule = [SELECT Id,CronJobDetail.Name FROM CronTrigger WHERE CronJobDetail.Name ='UpdateDataBatch' LIMIT 1];
        if( !rountingEngineSchedule.isEmpty() ){
            System.abortJob(rountingEngineSchedule[0].id );
        }
    }
    
    //This will start job
    public static void startUpdateDataBatch(integer minutesAfter ){
        Utility.stopUpdateDataBatch();
        UpdateDataBatch nextBatch = new UpdateDataBatch();
        nextBatch.intervalInMinutes = minutesAfter;
        datetime nextSchedule = datetime.now().addMinutes(minutesAfter);
        String sch = '0 ' + nextSchedule.minute() + ' ' + nextSchedule.hour() + ' * * ?';
        system.schedule('UpdateDataBatch', sch, nextBatch);
    }
}