package com.fh.shop.admin.interceptor;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println(request.getRequestURI());
        if(request.getSession().getAttribute("user") != null){

            return true;
        }else{
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return false;
        }
    }
}
