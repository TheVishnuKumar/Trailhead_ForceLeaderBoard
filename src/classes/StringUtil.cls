//percentEncodes a string according to the specification 
// here: https://dev.twitter.com/docs/auth/percent-encoding-parameters

public class StringUtil {
    private static final set<String> VALID_CHARS = new set<String>
    {'30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '41', '42', '43', '44', '45', '46', '47', 
     '48', '49', '4A', '4B', '4C', '4D', '4E', '4F', '50', '51', '52', '53', '54', '55', '56', '57', '58',
     '59', '5A', '61', '62', '63', '64', '65', '66', '67', '68', '69', '6A', '6B', '6C', '6D', '6E', '6F', 
     '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '7A', '2D', '2E', '5F', '7E'};
    public static String percentEncode(String s) {
        String DST = '';
        for(Integer i=0; i<s.length(); i++) {
            String val = s.substring(i, i+1);
            String iHex = EncodingUtil.convertToHex(blob.valueOf(val));
            if(VALID_CHARS.contains(iHex.toUpperCase())) 
                DST += val;
            else 
                DST += '%' + iHex.toUpperCase();
        }
        return DST;
    }
}