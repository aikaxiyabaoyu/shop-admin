package com.fh.shop.admin.common;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class WebContextFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        //把页面发送的request给我们定义的threadLocal
        WebContext.set((HttpServletRequest) request);
        chain.doFilter(request,response);
    }

    @Override
    public void destroy() {

    }
}
