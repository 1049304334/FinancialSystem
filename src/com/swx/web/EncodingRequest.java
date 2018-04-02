package com.swx.web;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

/**
 * <request装饰类，编码过滤器使用>
 * 
 * @author zj
 * @version [V1.0.0,2017-4-10]
 *
 */
public class EncodingRequest extends HttpServletRequestWrapper {
	private HttpServletRequest req;
	private String encoding;

	public EncodingRequest(HttpServletRequest request, String encoding) {
		super(request);
		this.req = request;
		this.encoding = encoding;
	}

	public String getParameter(String name) {
		String value = req.getParameter(name);
		// 处理编码问题
		try {
			if(null!=value&&!"".equals(value)){
				value = new String(value.getBytes("iso-8859-1"), encoding);
			}
			
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e);
		}

		return value;
	}
}
