package com.swx.util;

/**
 * 生成主键
 * @author swx
 *
 */
public class PrimaryKeyUtil {

    private static int serialNum = 0;

    private PrimaryKeyUtil() {

    };

    public static final PrimaryKeyUtil util = new PrimaryKeyUtil();

    public static PrimaryKeyUtil getKeyUtil(){
        return util;
    }

    public static String getKey(){
        String serial = String.format("%4d", serialNum).replace(" ", "0");
        String timeStamp = String.valueOf(System.currentTimeMillis());
        serialNum++;
        if (serialNum==600){
            serialNum=0;
        }
        String key = timeStamp + serial;
	    return key;
    }
}
