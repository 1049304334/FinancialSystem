package com.swx.util;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2018/3/29.
 */
public class ReqParamToMap {

    /**
     * 用于将请求中所有的参数提取出来放入一个HashMap并返回，免于手动取赋值
     * @param req
     * @return
     */
    public static HashMap<String,Object> param2Map(HttpServletRequest req){
        HashMap<String, Object> paramMap = new HashMap<String,Object>();
        Enumeration enu=req.getParameterNames();
        while(enu.hasMoreElements()){
            String paraName=(String)enu.nextElement();
            paramMap.put(paraName,req.getParameter(paraName));
        }
        return paramMap;
    }
}
