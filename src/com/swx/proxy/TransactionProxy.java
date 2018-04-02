package com.swx.proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.swx.transaction.TransManagerI;
import com.swx.transaction.impl.TransManagerImpl;

public class TransactionProxy {
	private static TransManagerI transManager = new TransManagerImpl();

	// 被代理类

	public static Object createProxy(final Object target) {

		// 通过JDK创建的动态代理
		Object proxyObject = Proxy.newProxyInstance(target.getClass().getClassLoader(), target.getClass().getInterfaces(),
				new InvocationHandler() {

					public Object invoke(Object proxy, Method method,Object[] args) throws Throwable {
						Object res = null;
						try {
							transManager.beginTrans();
							res = method.invoke(target, args);
							transManager.commitTrans();
						} catch (Exception e) {
							transManager.rollbackTrans();
						}

						return res;
					}
				});
		return proxyObject;
	}

}
