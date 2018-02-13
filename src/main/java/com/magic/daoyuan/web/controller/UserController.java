package com.magic.daoyuan.web.controller;

import com.magic.daoyuan.business.entity.User;
import com.magic.daoyuan.business.enums.Common;
import com.magic.daoyuan.business.service.UserService;
import com.magic.daoyuan.business.util.CommonUtil;
import com.magic.daoyuan.business.util.LoginHelper;
import com.magic.daoyuan.business.util.StatusConstant;
import com.magic.daoyuan.web.util.ViewData;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * HR端 用户控制器
 */
@RestController
@RequestMapping("/user")
public class UserController extends BaseController {

    @Resource
    private UserService userService;

    /**
     * HR 登录接口
     * @param account
     * @param pwd
     * @param request
     * @return
     */
    @RequestMapping("/login")
    public ViewData login(String account, String pwd, HttpServletRequest request){
        if(CommonUtil.isEmpty(account,pwd)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        User user = userService.queryUserByAccount(account);
        if(null == user){
            return buildFailureJson(StatusConstant.USER_DOES_NOT_EXIST,"帐号不存在");
        }
        if(Common.NO.ordinal() == user.getIsValid()){
            return buildFailureJson(StatusConstant.ACCOUNT_FROZEN,"帐号无效,请联系管理员");
        }
        if(!pwd.equals(user.getPwd())){
            return buildFailureJson(StatusConstant.PASSWORD_ERROR,"密码错误");
        }
        request.getSession().setAttribute(LoginHelper.SESSION_USER,user);
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,"登录成功",user);
    }

    /**
     * HR 退出登录接口
     * @param request
     * @return
     */
    @RequestMapping("/logout")
    public ViewData logout(HttpServletRequest request){
        request.getSession().invalidate();
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }
}
