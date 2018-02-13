package com.magic.daoyuan.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 页面控制器
 */
@Controller
@RequestMapping("/page")
public class PageController {

    /**全部明细**/
    @RequestMapping("/h5/allDetail")
    public String allDetail() { return "/h5/allDetail"; }

    /**登录页面**/
    @RequestMapping("/login")
    public String login() { return "/web/login"; }

    /**联系我们页面**/
    @RequestMapping("/contactUs")
    public String contactUs() { return "/web/contactUs"; }

    /**账单列表页面**/
    @RequestMapping("/billList")
    public String billList() { return "/web/billList"; }

    /**个人资料页面**/
    @RequestMapping("/personData")
    public String personData() { return "/web/personData"; }

    /**修改密码页面**/
    @RequestMapping("/changePassword")
    public String changePassword() { return "/web/changePassword"; }

    /**我的页面**/
    @RequestMapping("/myBill")
    public String myBill() { return "/web/myBill"; }

}
