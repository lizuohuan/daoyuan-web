package com.magic.daoyuan.web.controller;

import com.alibaba.fastjson.JSONArray;
import com.magic.daoyuan.business.entity.Company;
import com.magic.daoyuan.business.entity.Contacts;
import com.magic.daoyuan.business.enums.Common;
import com.magic.daoyuan.business.exception.InterfaceCommonException;
import com.magic.daoyuan.business.service.CompanyService;
import com.magic.daoyuan.business.util.CommonUtil;
import com.magic.daoyuan.business.util.LoginHelper;
import com.magic.daoyuan.business.util.StatusConstant;
import com.magic.daoyuan.web.util.ViewData;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 公司信息
 * @author lzh
 * @create 2017/12/19 14:39
 */
@RestController
@RequestMapping("/company")
public class CompanyController extends BaseController {

    @Resource
    private CompanyService companyService;


    /**
     * 通过公司Id获取 公司
     * @return
     */
    @RequestMapping("/infoAndContactsList")
    public ViewData infoAndContactsList(){
        Company company = LoginHelper.getCurrentHrUser();
        return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",
                companyService.infoAndContactsList(company.getId()));
    }


    /**
     * 更新公司
     * @return
     */
    @RequestMapping("/updateAndContacts")
    public ViewData updateAndContacts(Company company, String contactJsonArr){
        Company companySession = LoginHelper.getCurrentHrUser();
        company.setId(companySession.getId());
        if(CommonUtil.isEmpty(contactJsonArr)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        try {
            List<Contacts> contactsList = JSONArray.parseArray(contactJsonArr,Contacts.class);
            companyService.updateAndContacts(company,contactsList);
        } catch (InterfaceCommonException e) {
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"操作失败");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }

    /**
     * 更新公司
     * @return
     */
    @RequestMapping("/updatePwd")
    public ViewData updatePwd(String oldPwd, String newPwd){
        if(CommonUtil.isEmpty(oldPwd,newPwd)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        try {
            Company company = LoginHelper.getCurrentHrUser();
            Company company1 = companyService.infoAndContactsList(company.getId());
            if (null == company1) {
                return buildFailureJson(StatusConstant.NO_DATA,"未知的公司");
            }
            if (!company1.getPwd().equals(oldPwd)) {
                return buildFailureJson(StatusConstant.PASSWORD_ERROR,"旧密码错误");
            }
            company1.setPwd(newPwd);
            companyService.update(company1);
        } catch (InterfaceCommonException e) {
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"操作失败");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }

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
        Company company = companyService.hrLogin(account);
        if(null == company){
            return buildFailureJson(StatusConstant.USER_DOES_NOT_EXIST,"帐号不存在");
        }
        if(Common.NO.ordinal() == company.getIsValid()){
            return buildFailureJson(StatusConstant.ACCOUNT_FROZEN,"帐号无效,请联系管理员");
        }
        if(!pwd.equals(company.getPwd())){
            return buildFailureJson(StatusConstant.PASSWORD_ERROR,"密码错误");
        }
        request.getSession().setAttribute(LoginHelper.SESSION_HR_USER,company);
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,"登录成功",company);
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
