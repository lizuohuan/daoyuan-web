package com.magic.daoyuan.web.interceptor;

import com.magic.daoyuan.business.entity.Company;
import com.magic.daoyuan.business.entity.User;
import com.magic.daoyuan.business.util.LoginHelper;
import com.magic.daoyuan.web.controller.BaseController;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Eric Xie on 2017/7/12 0012.
 */
public class LoginInterceptor extends BaseController implements HandlerInterceptor {
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {

        String requestURI = httpServletRequest.getRequestURI();
        Company user = (Company) httpServletRequest.getSession().getAttribute(LoginHelper.SESSION_HR_USER);
        httpServletResponse.setCharacterEncoding("UTF-8");
        httpServletResponse.setCharacterEncoding("UTF-8");
        if (!requestURI.contains("login") && !requestURI.contains("h5Data") && !requestURI.contains("businessInsurance")
                && !requestURI.contains("companySonBillItem") && !requestURI.contains("export")
                && !requestURI.contains("h5")) {
            if(null == user){
                httpServletResponse.sendRedirect(httpServletRequest.getContextPath()+"/page/login");
                return false;
            }
        }
        return true;
    }

    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }


}
