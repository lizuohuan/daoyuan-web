package com.magic.daoyuan.web.controller;

import com.magic.daoyuan.business.exception.InterfaceCommonException;
import com.magic.daoyuan.business.service.CompanySonBillItemService;
import com.magic.daoyuan.business.util.CommonUtil;
import com.magic.daoyuan.business.util.StatusConstant;
import com.magic.daoyuan.web.util.ViewData;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;

/**
 * 公司子账单子类
 * @author lzh
 * @create 2017/10/13 11:07
 */
@RestController
@RequestMapping("/companySonBillItem")
public class CompanySonBillItemController extends BaseController {

    @Resource
    private CompanySonBillItemService companySonBillItemService;


    /**
     * 确认数据
     * @param companySonTotalBillId 汇总账单id
     * @return
     */
    @RequestMapping("/updateStatus")
    public ViewData updateStatus(Integer companySonTotalBillId){
        if(CommonUtil.isEmpty(companySonTotalBillId)){
            return buildFailureJson(StatusConstant.Fail_CODE,"操作失败");
        }
        try {
            companySonBillItemService.updateStatus(companySonTotalBillId,2);
        } catch (InterfaceCommonException e) {
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        }catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE," 操作失败 ");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }

    /**
     * 确认数据后取消确认
     * @param companySonTotalBillId 汇总账单id
     * @return
     */
    @RequestMapping("/updateStatus2")
    public ViewData updateStatus2(Integer companySonTotalBillId){
        if(CommonUtil.isEmpty(companySonTotalBillId)){
            return buildFailureJson(StatusConstant.Fail_CODE,"操作失败");
        }
        try {
            companySonBillItemService.updateStatus(companySonTotalBillId,0);
        } catch (InterfaceCommonException e) {
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        }catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"操作失败");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }

    /**
     * 驳回数据
     * @param companySonTotalBillId 汇总账单id
     * @param createTime 创建时间
     * @return
     */
    @RequestMapping("/delete")
    public ViewData delete(Integer companySonTotalBillId,Long createTime){
        if(CommonUtil.isEmpty(companySonTotalBillId,createTime)){
            return buildFailureJson(StatusConstant.Fail_CODE,"操作失败");
        }
        try {
            companySonBillItemService.delete(companySonTotalBillId,new Date(createTime));
        } catch (InterfaceCommonException e) {
            return buildFailureJson(e.getErrorCode(),e.getMessage());
        }catch (Exception e) {
            logger.error(e.getMessage(),e);
            return buildFailureJson(StatusConstant.Fail_CODE,"操作失败");
        }
        return buildSuccessCodeJson(StatusConstant.SUCCESS_CODE,"操作成功");
    }


}
