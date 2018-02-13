package com.magic.daoyuan.web.controller;

import com.magic.daoyuan.business.entity.*;
import com.magic.daoyuan.business.service.*;
import com.magic.daoyuan.business.util.StatusConstant;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Eric Xie on 2017/10/24 0024.
 */

@Controller
@RequestMapping("/export")
public class ExportExcelController extends BaseController {

    @Resource
    private ExportExcelService exportExcelService;

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
    @Resource
    private BusinessInsuranceService businessInsuranceService;

    @RequestMapping("/downLoad")
    public void exportData(HttpServletResponse response,Integer companySonTotalBillId,Long createTime){
        try {
            if(null == companySonTotalBillId || null == createTime){
                response.getWriter().print(buildFailureJson(StatusConstant.ARGUMENTS_EXCEPTION,"参数异常"));
                return;
            }
            List<CompanySonBillItem> companySonBillItems = companySonBillItemService.
                    getByCompanySonBillIdAndCreateTime(companySonTotalBillId, new Date(createTime));
            if (companySonBillItems.size() < 1) {
                response.getWriter().print(buildFailureJson(StatusConstant.NO_DATA,"暂无账单 "));
                return;
            }
            //汇总账单
            CompanySonTotalBill companySonTotalBill = companySonTotalBillService.info(companySonBillItems.get(0).getCompanySonTotalBillId());
            if (null == companySonTotalBill) {
                response.getWriter().print(buildSuccessCodeJson(StatusConstant.NO_DATA,"未知的账单"));
                return;
            }
            // 总数据
            Map<String, Object> totalData = companySonBillItemService.getTheTotalBill2(companySonBillItems, companySonTotalBill.getUserId(), companySonTotalBill.getId(),companySonTotalBill.getCompanySonBillId(),
                    new Date(createTime));
            // 社保
            List<SocialSecurityInfo> securityInfos = socialSecurityInfoService.list(companySonTotalBillId,companySonTotalBill.getBillMonth());
            // 公积金
            List<ReservedFundsInfo> reservedFundsInfos = reservedFundsInfoService.list(companySonTotalBillId,companySonTotalBill.getBillMonth());
            // 工资
            List<SalaryInfo> salaryInfos = salaryInfoService.querySalaryInfo(companySonTotalBillId);
            Map<String, Object> map = businessInsuranceService.getBusinessInsurance(companySonTotalBillId);
            List<BusinessInsurance> businessInsuranceList = (List<BusinessInsurance>) map.get("businessInsurance");
            List<BusinessYc> businessYcList = (List<BusinessYc>) map.get("businessYc");
            exportExcelService.exportBillDetail(response,totalData,securityInfos,reservedFundsInfos,salaryInfos,businessInsuranceList,
                    businessYcList,createTime);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }


    }

}
