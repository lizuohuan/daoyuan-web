package com.magic.daoyuan.web.controller;

import com.magic.daoyuan.business.entity.Company;
import com.magic.daoyuan.business.entity.CompanySonBillItem;
import com.magic.daoyuan.business.entity.CompanySonTotalBill;
import com.magic.daoyuan.business.exception.InterfaceCommonException;
import com.magic.daoyuan.business.service.*;
import com.magic.daoyuan.business.util.CommonUtil;
import com.magic.daoyuan.business.util.LoginHelper;
import com.magic.daoyuan.business.util.StatusConstant;
import com.magic.daoyuan.web.util.ViewData;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Eric Xie on 2017/10/20 0020.
 */
@RestController
@RequestMapping("/h5Data")
public class H5Controller extends BaseController {


    @Resource
    private SalaryInfoService salaryInfoService;
    @Resource
    private SocialSecurityInfoService socialSecurityInfoService;
    @Resource
    private ReservedFundsInfoService reservedFundsInfoService;
    @Resource
    private CompanySonBillItemService companySonBillItemService;
    @Resource
    private CompanySonTotalBillService companySonTotalBillService;
    /**
     * 获取工资
     * @param companySonTotalBillId
     * @return
     */
    @RequestMapping("/getSalaryInfo")
    public ViewData getSalaryInfo(Integer companySonTotalBillId){
        if(null == companySonTotalBillId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",
                salaryInfoService.querySalaryInfo(companySonTotalBillId));
    }


    /**
     * 获取社保缴纳明细
     * @param companySonTotalBillId 汇总id
     * @return
     */
    @RequestMapping("/getSocialSecurityInfo")
    public ViewData getSocialSecurityInfo(Integer companySonTotalBillId){
        if(null == companySonTotalBillId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        //汇总账单
        CompanySonTotalBill companySonTotalBill = companySonTotalBillService.info(companySonTotalBillId);
        if (null == companySonTotalBill) {
            return buildSuccessCodeJson(StatusConstant.NO_DATA,"未知的账单");
        }
        return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",
                socialSecurityInfoService.list(companySonTotalBillId,companySonTotalBill.getBillMonth()));
    }


    /**
     * 获取公积金明细
     * @param companySonTotalBillId 汇总id
     * @return
     */
    @RequestMapping("/getReservedFundsInfo")
    public ViewData getReservedFundsInfo(Integer companySonTotalBillId){
        if(null == companySonTotalBillId){
            return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        //汇总账单
        CompanySonTotalBill companySonTotalBill = companySonTotalBillService.info(companySonTotalBillId);
        if (null == companySonTotalBill) {
            return buildSuccessCodeJson(StatusConstant.NO_DATA,"未知的账单");
        }
        return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",
                reservedFundsInfoService.list(companySonTotalBillId,companySonTotalBill.getBillMonth()));
    }
    /**
     * 获取总账单
     * @param companySonBillItemId
     * @return
     */
//    @RequestMapping("/getTheTotalBill")
//    public ViewData getTheTotalBill(Integer companySonBillItemId){
//        try {
//            CompanySonBillItem companySonBillItem = companySonBillItemService.info(companySonBillItemId);
//            if (null == companySonBillItem) {
//                return buildSuccessCodeJson(StatusConstant.NO_DATA,"未知的子账单 ");
//            }
//            //汇总账单
//            CompanySonTotalBill companySonTotalBill = companySonTotalBillService.info(companySonBillItem.getCompanySonTotalBillId());
//            if (null == companySonTotalBill) {
//                return buildSuccessCodeJson(StatusConstant.NO_DATA,"未知的账单");
//            }
//            List<CompanySonBillItem> companySonBillItems = new ArrayList<CompanySonBillItem>();
//            companySonBillItems.add(companySonBillItem);
//            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功 ",
//                    companySonBillItemService.getTheTotalBill(companySonBillItems,companySonTotalBill.getUserId()));
//        } catch (InterfaceCommonException e) {
//            logger.info(e.getMessage(),e.getErrorCode());
//            return buildFailureJson(e.getErrorCode(),e.getMessage());
//        } catch (Exception e) {
//            logger.error(" 服务器超时，获取总账单失败 ",e);
//            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，获取总账单失败 ");
//        }
//    }


    /**
     * 获取最终总账单详情 同一时间生成的总账单和
     * @param companySonTotalBillId 汇总账单id
     * @param createTime 创建时间
     * @return
     */
    @RequestMapping("/getTheTotalBillInfo")
    public ViewData getTheTotalBillInfo(Integer companySonTotalBillId,Long createTime){
        try {
            if (CommonUtil.isEmpty(companySonTotalBillId,createTime)) {
                return buildFailureJson(StatusConstant.FIELD_NOT_NULL,"字段不能为空 ");
            }
//            Company company = LoginHelper.getCurrentHrUser();
            List<CompanySonBillItem> companySonBillItems = companySonBillItemService.
                    getByCompanySonBillIdAndCreateTime(companySonTotalBillId, new Date(createTime));
            if (companySonBillItems.size() < 1) {
                return buildFailureJson(StatusConstant.NO_DATA,"暂无账单 ");
            }
            //汇总账单
            CompanySonTotalBill companySonTotalBill = companySonTotalBillService.info(companySonBillItems.get(0).getCompanySonTotalBillId());
            if (null == companySonTotalBill) {
                return buildSuccessCodeJson(StatusConstant.NO_DATA,"未知的账单");
            }
//            if (!company.getId().equals(companySonTotalBill.getCompanyId())) {
//                return buildSuccessCodeJson(StatusConstant.Fail_CODE,"这不是你的账单，不能查看");
//            }
            return buildSuccessViewData(StatusConstant.SUCCESS_CODE,"获取成功",
                    companySonBillItemService.getTheTotalBill2(companySonBillItems,companySonTotalBill.getUserId(),companySonTotalBill.getId(),companySonTotalBill.getCompanySonBillId(),
                            new Date(createTime)));
        } catch (InterfaceCommonException e) {
            logger.info(e.getMessage(),e.getErrorCode());
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        } catch (Exception e) {
            logger.error(" 服务器超时，合并总账单失败 ",e);
            return buildFailureJson(StatusConstant.Fail_CODE,"服务器超时，合并总账单失败 ");
        }
    }
}
