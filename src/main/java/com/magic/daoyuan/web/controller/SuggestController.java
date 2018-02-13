package com.magic.daoyuan.web.controller;

import com.magic.daoyuan.business.entity.Company;
import com.magic.daoyuan.business.entity.Suggest;
import com.magic.daoyuan.business.entity.User;
import com.magic.daoyuan.business.service.SuggestService;
import com.magic.daoyuan.business.util.CommonUtil;
import com.magic.daoyuan.business.util.LoginHelper;
import com.magic.daoyuan.business.util.StatusConstant;
import com.magic.daoyuan.web.util.ViewData;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * 意见反馈
 * Created by Eric Xie on 2017/7/13 0013.
 */
@RestController
@RequestMapping("/suggest")
public class SuggestController extends BaseController {

    @Resource
    private SuggestService suggestService;


    /**
     * 提交意见反馈
     * @param content
     * @return
     */
    @RequestMapping(value = "/submitSuggest",method = RequestMethod.POST)
    public ViewData addSuggest(String content){
        if(CommonUtil.isEmpty(content)){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        try {
            Suggest suggest = new Suggest();
            Company company = LoginHelper.getCurrentHrUser();
            suggest.setCompanyId(company.getId());
            suggest.setContent(content);
            suggestService.addSuggest(suggest);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"提交失败");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"提交成功");
    }

}
