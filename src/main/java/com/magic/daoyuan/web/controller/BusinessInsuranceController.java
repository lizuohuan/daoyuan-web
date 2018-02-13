package com.magic.daoyuan.web.controller;

import com.magic.daoyuan.business.service.BusinessInsuranceService;
import com.magic.daoyuan.business.util.StatusConstant;
import com.magic.daoyuan.web.util.ViewData;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * Created by Eric Xie on 2017/10/25 0025.
 */

@RestController
@RequestMapping("/businessInsurance")
public class BusinessInsuranceController extends BaseController {


    @Resource
    private BusinessInsuranceService businessInsuranceService;



    @RequestMapping("/getBusinessInsurance")
    public ViewData getBusinessInsurance(Integer companySonTotalBillId){
        if(null == companySonTotalBillId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",
                businessInsuranceService.getBusinessInsurance(companySonTotalBillId));
    }


}
