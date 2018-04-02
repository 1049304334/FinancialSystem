package com.swx.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.swx.web.EncodingRequest;

public class EncodingFilter implements Filter {

	private FilterConfig filterConfig = null;

	public void init(FilterConfig fConfig) throws ServletException {
		this.filterConfig = fConfig;
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		String encoding = filterConfig.getInitParameter("charset");

		HttpServletRequest req = (HttpServletRequest) request;

		if (req.getMethod().equals("GET")) {
			// 处理GET请求的编码问题
			EncodingRequest er = new EncodingRequest(req, encoding);
			chain.doFilter(er, response);
		} else if (req.getMethod().equals("POST")) {
			// 处理post请求编码问题
			request.setCharacterEncoding(encoding);
			response.setCharacterEncoding(encoding);
			chain.doFilter(request, response);
		}
	}

	public void destroy() {

	}

}
