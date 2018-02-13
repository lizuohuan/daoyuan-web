package com.magic.daoyuan.web.controller;

import com.magic.daoyuan.business.entity.Company;
import com.magic.daoyuan.business.entity.PageArgs;
import com.magic.daoyuan.business.entity.PageList;
import com.magic.daoyuan.business.service.HrBillListDtoService;
import com.magic.daoyuan.business.util.CommonUtil;
import com.magic.daoyuan.business.util.LoginHelper;
import com.magic.daoyuan.business.util.StatusConstant;
import com.magic.daoyuan.business.util.Timestamp;
import com.magic.daoyuan.web.util.ViewDataPage;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * hr（web）端账单列表
 * @author lzh
 * @create 2017/12/19 14:31
 */
@RestController
@RequestMapping("/hrBill")
public class HrBillListDtoController extends BaseController {

    @Resource
    private HrBillListDtoService hrBillListDtoService;

    /**
     * hr（web）端页面 分页获取账单列表
     * @param pageArgs 分页属性
     * @param billMonth 账单月
     * @param affirmTime 账单确认时间
     * @param amount 账单金额
     * @param businessId 业务类型
     * @param businessName 业务名
     * @return
     */
    @RequestMapping("/list")
    public ViewDataPage list(PageArgs pageArgs , Long billMonth , Long affirmTime,
                             Double amount , Integer businessId, String businessName) {
        try {
            Company companySession = LoginHelper.getCurrentHrUser();
            Date billMonthD = null;
            Date affirmTimeD = null;
            if (!CommonUtil.isEmpty(billMonth)) {
                billMonthD = new Date(billMonth);
            }
            if (!CommonUtil.isEmpty(affirmTime)) {
                affirmTimeD = new Date(affirmTime);
            }
            List<Integer> businessIds = new ArrayList<Integer>();
            if (!CommonUtil.isEmpty(businessId)) {
                businessIds.add(businessId);
            }
            if (!CommonUtil.isEmpty(businessName)) {
                if (businessName.contains("社") || businessName.contains("保")) {
                    businessIds.add(3);
                }
                if (businessName.contains("公") || businessName.contains("积") || businessName.contains("金")) {
                    businessIds.add(4);
                }
                if (businessName.contains("工") || businessName.contains("资")) {
                    businessIds.add(5);
                }
            }

            PageList pageList = hrBillListDtoService.list(pageArgs, billMonthD, affirmTimeD, amount, businessIds, businessName,companySession.getId());
            return buildSuccessViewDataPage(StatusConstant.SUCCESS_CODE,"获取成功 ",pageList.getTotalSize(),pageList.getList());
        } catch (Exception e) {
            logger.error("服务器超时，获取失败",e);
            return buildFailureJsonPage(StatusConstant.Fail_CODE,"服务器超时，获取失败 ");
        }
    }
}
