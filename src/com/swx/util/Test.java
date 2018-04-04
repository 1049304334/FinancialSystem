package com.swx.util;

import com.swx.po.User;

/**
 * Created by Administrator on 2018/3/22.
 */
public class Test {

    public static void testM(Object obj){
        String className = String.valueOf(obj.getClass());
        int i = className.lastIndexOf(".");
    }

    public static void main(String[] args){
        User user = new User();
        testM(user);
    }

}
