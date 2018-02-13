<!-- 解决layer.open 不居中问题 -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>账单明细</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/plugins/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/plugins/font-awesome/css/font-awesome.min.css">
    <style>
        *{font-family: 微软雅黑 !important;}
        [ng-cloak]{display: none}
        .title{text-align: center;padding: 15px;font-size: 24px;font-weight: bold}
        .bill-div{width: 500px;border: 1px solid #e1e4e9;margin: 0 auto;font-family: "微软雅黑";}
        .bill-div table{width: 100%}
        .bill-div table tr{ height: 50px; border-bottom: 1px solid #e1e4e9;}
        .bill-div table tr td{font-size: 13px;}
        .bill-div table tr:last-child{border-bottom: none}
        .left{text-align: left !important;padding-left: 15px;width: 150px;}
        .right{text-align: right !important;padding-right: 15px;}
        .align-left{text-align: left !important;padding: 15px;}
        .commonSeal{text-align: right}
        .commonSeal img{width: 150px;height: 150px;position: absolute; margin: -80px 0 0 10px;}
        .date{text-align: right;font-size: 18px;}
        .not-data{text-align: center;color: #999999;padding: 30px;}

        .detail-div{padding: 15px;}
        .detail-div table{width: 100%}
        .detail-div table tr td, th {text-align: center;font-size: 13px; padding: 15px;border-left:1px solid #e1e1e1;border-top:1px solid #e1e1e1;border-right: 1px solid #e1e1e1;}
        .detail-div table{border-right:1px solid #e1e1e1;border-bottom:1px solid #e1e1e1}

        .button-bar{
            text-align: center;
            padding: 15px;
        }
        .btn-danger{
            background-color: #FF5722;
            display: inline-block;
            height: 38px;
            line-height: 38px;
            padding: 0 18px;
            color: #fff;
            white-space: nowrap;
            text-align: center;
            font-size: 14px;
            border: none;
            border-radius: 2px;
            cursor: pointer;
            opacity: .9;
            filter: alpha(opacity=90);
        }
        .btn-warm{
            background-color: #F7B824;
            display: inline-block;
            height: 38px;
            line-height: 38px;
            padding: 0 18px;
            color: #fff;
            white-space: nowrap;
            text-align: center;
            font-size: 14px;
            border: none;
            border-radius: 2px;
            cursor: pointer;
            opacity: .9;
            filter: alpha(opacity=90);
        }
        .btn-normal{
            background-color: #1E9FFF;
            display: inline-block;
            height: 38px;
            line-height: 38px;
            padding: 0 18px;
            color: #fff;
            white-space: nowrap;
            text-align: center;
            font-size: 14px;
            border: none;
            border-radius: 2px;
            cursor: pointer;
            opacity: .9;
            filter: alpha(opacity=90);
        }
        .hide{display: none}
        .layui-tab-title{text-align: center;position: absolute;top: 0;width: 100%;z-index: 99;}
        .layui-tab{width: 100%;overflow: auto}
        .layui-tab-content{padding-top: 60px;}
        .layui-tab-content .detail-div{min-width: 1200px;overflow: auto;}
    </style>
</head>
<body ng-app="webApp" ng-controller="controller" ng-cloak>

<div class="layui-tab layui-tab-brief">
    <ul class="layui-tab-title">
        <li class="layui-this">总账单</li>
        <li ng-if="socialSecurityList.length != 0">社保明细</li>
        <li ng-if="accumulationFundList.length != 0">公积金明细</li>
        <li ng-if="salaryList.length != 0">工资明细</li>
        <li ng-if="businessInsuranceList.length > 0 || businessYc.length > 0">专项服务明细</li>
    </ul>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show">
            <h2 class="title">{{totalBill.companyName}}{{totalBill.createTime | date : "yyyy-MM"}}账单</h2>
            <div class="bill-div">
                <table>
                    <tr ng-if="totalBill.socialSecurityPay > 0">
                        <td class="left">社保款</td>
                        <td class="right"></td>
                        <td class="left">￥{{totalBill.socialSecurityPay}}</td>
                        <td></td>
                    </tr>
                    <tr ng-if="totalBill.reservedFundPay > 0">
                        <td class="left">公积金款</td>
                        <td class="right"></td>
                        <td class="left">￥{{totalBill.reservedFundPay}}</td>
                        <td class="right"></td>
                    </tr>
                    <tr ng-if="totalBill.salaryPay > 0">
                        <td class="left">工资款</td>
                        <td class="right"></td>
                        <td class="left">￥{{totalBill.salaryPay}}</td>
                        <td class="right"></td>
                    </tr>
                    <tr ng-if="totalBill.serviceFee > 0">
                        <td class="left">服务费</td>
                        <td class="right"></td>
                        <td class="left">￥{{totalBill.serviceFee}}</td>
                        <td class="right"></td>
                    </tr>
                    <tr ng-if="totalBill.businessInsurancePrice > 0">
                        <td class="left">其他周期性服务</td>
                        <td class="right"></td>
                        <td class="left">￥{{totalBill.businessInsurancePrice}}</td>
                        <td></td>
                    </tr>
                    <tr ng-if="totalBill.countBusinessYc > 0">
                        <td class="left">一次性服务</td>
                        <td class="right"></td>
                        <td class="left">￥{{totalBill.countBusinessYc}}</td>
                        <td class="right"></td>
                    </tr>
                    <tr>
                        <td class="left">合计</td>
                        <td class="right"></td>
                        <td class="left">￥{{totalBill.totalPay}}</td>
                        <td class="right"></td>
                    </tr>
                    <tr>
                        <td class="left">上月余额</td>
                        <td class="right"></td>
                        <td class="left">￥0</td>
                        <td class="right"></td>
                    </tr>
                    <tr>
                        <td class="left">本月应到款</td>
                        <td class="right"></td>
                        <td class="left">￥0</td>
                        <td class="right"></td>
                    </tr>
                    <tr>
                        <td class="left">账单制作人：</td>
                        <td class="right"></td>
                        <td class="left">{{totalBill.producer}}</td>
                        <td class="right"></td>
                    </tr>
                    <tr>
                        <td class="left">联系方式：</td>
                        <td class="right"></td>
                        <td class="left">{{totalBill.phone}}</td>
                        <td class="right"></td>
                    </tr>
                    <tr>
                        <td class="left">账单制作日期：</td>
                        <td class="right"></td>
                        <td class="left commonSeal">{{totalBill.createTime | date : "yyyy-MM-dd"}}
                            <img src="<%=request.getContextPath()%>/resources/img/5.jpg">
                        </td>
                        <td class="right"></td>
                    </tr>
                    <tr>
                        <td colspan="4" class="align-left">
                            如您对《账单》有任何疑问，请及时联系您的客服：{{totalBill.producer}}。我们将竭诚为您服务！
                            <br>
                            若您确认此账单无疑问，请在下方点击“确认账单”，并按照贵我双方约定的到款日为每月{{totalBill.payTime}}号，请在此日期之前付款，感谢您对我们的支持！
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align="center">我们的收款信息</td>
                    </tr>
                    <tr>
                        <td class="left">账户名</td>
                        <td class="right"></td>
                        <td class="left" colspan="2">四川省道远人力资源管理有限公司</td>
                    </tr>
                    <tr>
                        <td class="left">银行账号</td>
                        <td class="right"></td>
                        <td class="left" colspan="2">4402 2060 1910 0055 819</td>
                    </tr>
                    <tr>
                        <td class="left">开户行</td>
                        <td class="right"></td>
                        <td class="left" colspan="2">中国工商银行股份有限公司成都东大街支行</td>
                    </tr>
                    <tr>
                        <td class="left">联行号</td>
                        <td class="right"></td>
                        <td class="left" colspan="2">102651020607</td>
                    </tr>
                    <tr>
                        <td colspan="4" align="center">or 支付宝</td>
                    </tr>
                    <tr>
                        <td class="left">支付宝名称</td>
                        <td class="right"></td>
                        <td class="left" colspan="2">四川省道远人力资源管理有限公司</td>
                    </tr>
                    <tr>
                        <td class="left">支付宝账号</td>
                        <td class="right"></td>
                        <td class="left" colspan="2">scdy@cdhro.com</td>
                    </tr>
                </table>
            </div>
            <div class="button-bar">
                <button ng-show="totalBill.status == 0" class="btn-danger" ng-click="turnDown()">驳回</button>
                <button ng-show="totalBill.status == 0" class="btn-warm" ng-click="confirmTheBill()">确认账单</button>
                <button ng-show="isShow || totalBill.status == 2" class="btn-normal" ng-click="downloadTheBill()">下载账单</button>
            </div>
        </div>
        <div class="layui-tab-item" ng-if="socialSecurityList.length != 0">
            <div class="detail-div">
                <table border="0" cellspacing="0" cellpadding="0" id="socialSecurityDetail">
                    <tr>
                        <th colspan="99" align="center">社保明细</th>
                    </tr>
                    <tr>
                        <th rowspan="2" scope="col">序号</th>
                        <th rowspan="2" scope="col">姓名</th>
                        <th rowspan="2" scope="col">证件编号</th>
                        <th rowspan="2" scope="col">社保编码</th>
                        <th rowspan="2" scope="col">缴金地-经办机构</th>
                        <th rowspan="2" scope="col">档次</th>
                        <th rowspan="2" scope="col">开始缴纳月</th>
                        <th rowspan="2" scope="col">本次服务年月</th>
                        <th rowspan="2" scope="col">缴纳基数</th>
                        <th colspan="{{companyInsuranceName.length}}" scope="col">公司缴纳部分</th>
                        <th colspan="{{personInsuranceName.length}}" scope="col">个人缴纳部分</th>
                        <th colspan="3" scope="col">汇总</th>
                    </tr>
                    <tr>
                        <td ng-repeat="type in companyInsuranceName">{{type.insuranceName}}</td>
                        <td ng-repeat="type in personInsuranceName">{{type.insuranceName}}</td>
                        <td>公司</td>
                        <td>个人</td>
                        <td>合计</td>
                    </tr>
                    <tr ng-repeat="data in socialSecurityList">
                        <td>{{$index + 1}}</td>
                        <td>{{data.userName}}</td>
                        <td>{{data.idCard}}</td>
                        <td>{{data.socialSecurityNum == null ? "次月可查" : data.socialSecurityNum}}</td>
                        <td>{{data.payPlaceOrganizationName}}社保局</td>
                        <td>{{data.insuranceLevelName}}</td>
                        <td>{{data.beginPayYM | date : "yyyyMM"}}</td>
                        <td>{{data.serviceNowYM | date : "yyyyMM"}}</td>
                        <td>{{data.payCardinalNumber}}</td>
                        <td ng-repeat="company in companyInsuranceName">
                            <span ng-repeat="item in data.socialSecurityInfoItems" ng-if="company.insuranceName == item.insuranceName && item.type == 0 && data.isProcessingScheme == 1">
                                {{item.payPrice - item.practicalPayPrice | number : 2}}
                            </span>
                            <span ng-repeat="item in data.socialSecurityInfoItems" ng-if="company.insuranceName == item.insuranceName && item.type == 0 && data.isProcessingScheme != 1">
                                {{item.payPrice | number : 2}}
                            </span>
                        </td>
                        <td ng-repeat="person in personInsuranceName">
                            <span ng-repeat="item in data.socialSecurityInfoItems" ng-if="person.insuranceName == item.insuranceName && item.type == 1 && data.isProcessingScheme == 1">
                                {{item.payPrice - item.practicalPayPrice | number : 2}}
                            </span>
                            <span ng-repeat="item in data.socialSecurityInfoItems" ng-if="person.insuranceName == item.insuranceName && item.type == 1 && data.isProcessingScheme != 1">
                                {{item.payPrice | number : 2}}
                            </span>
                        </td>
                        <td>
                            <span ng-if="data.isProcessingScheme == 1">
                                {{data.companyTotalPay - data.practicalCompanyTotalPay | number : 2}}
                            </span>
                            <span ng-if="data.isProcessingScheme != 1">
                                {{data.companyTotalPay | number : 2}}
                            </span>
                        </td>
                        <td>
                            <span ng-if="data.isProcessingScheme == 1">
                                {{data.memberTotalPay - data.practicalMemberTotalPay | number : 2}}
                            </span>
                            <span ng-if="data.isProcessingScheme != 1">
                                {{data.memberTotalPay | number : 2}}
                            </span>
                        </td>
                        <td>
                            <span ng-if="data.isProcessingScheme == 1">
                                {{(data.companyTotalPay + data.memberTotalPay) - (data.practicalCompanyTotalPay + data.practicalMemberTotalPay) | number : 2}}
                            </span>
                            <span ng-if="data.isProcessingScheme != 1">
                                {{data.companyTotalPay + data.memberTotalPay | number : 2}}
                            </span>
                        </td>
                    </tr>
                    <tfoot ng-show="socialSecurityList.length == 0"><tr><td colspan="99" class="not-data">暂无数据</td></tr></tfoot>
                </table>
            </div>
        </div>
        <div class="layui-tab-item" ng-if="accumulationFundList.length != 0">
            <div class="detail-div">
                <table border="0" cellspacing="0" cellpadding="0" id="accumulationFundDetail">
                    <tr>
                        <th colspan="99" align="center">公积金明细</th>
                    </tr>
                    <tr>
                        <th>序号</th>
                        <th>姓名</th>
                        <th>证件编号</th>
                        <th>个人客户号</th>
                        <th>缴金地-经办机构</th>
                        <th>比例</th>
                        <th>开始缴纳年月</th>
                        <th>本次服务年月</th>
                        <th>缴纳基数</th>
                        <th>公司缴纳部分</th>
                        <th>个人缴纳部分</th>
                        <th>合计</th>
                    </tr>
                    <tr ng-repeat="data in accumulationFundList">
                        <td>{{$index + 1}}</td>
                        <td>{{data.userName}}</td>
                        <td>{{data.idCard}}</td>
                        <td>{{data.memberNum == null ? "次月可查" : data.memberNum}}</td>
                        <td>{{data.payPlaceOrganizationName}}公积金中心</td>
                        <td>{{data.payRatio}}</td>
                        <td>{{data.beginPayYM | date : "yyyyMM"}}</td>
                        <td>{{data.serviceNowYM | date : "yyyyMM"}}</td>
                        <td>{{data.payCardinalNumber}}</td>
                        <td>
                            <span ng-if="data.isProcessingScheme == 1">
                                 {{data.companyTotalPay - data.practicalCompanyTotalPay | number : 2}}
                            </span>
                            <span ng-if="data.isProcessingScheme != 1">
                                {{data.companyTotalPay | number : 2}}
                            </span>
                        </td>
                        <td>
                            <span ng-if="data.isProcessingScheme == 1">
                                 {{data.memberTotalPay - data.practicalMemberTotalPay | number : 2}}
                            </span>
                            <span ng-if="data.isProcessingScheme != 1">
                                {{data.memberTotalPay | number : 2}}
                            </span>
                        </td>
                        <td>
                            <span ng-if="data.isProcessingScheme == 1">
                                {{(data.companyTotalPay + data.memberTotalPay) - (data.practicalCompanyTotalPay + data.practicalMemberTotalPay) | number : 2}}
                            </span>
                            <span ng-if="data.isProcessingScheme != 1">
                                {{data.companyTotalPay + data.memberTotalPay | number : 2}}
                            </span>
                        </td>
                    </tr>
                    <tfoot ng-show="accumulationFundList.length == 0"><tr><td colspan="99" class="not-data">暂无数据</td></tr></tfoot>
                </table>
            </div>
        </div>
        <div class="layui-tab-item" ng-if="salaryList.length != 0">
            <div class="detail-div">
                <table border="0" cellspacing="0" cellpadding="0" id="salaryDetail">
                    <tr>
                        <th colspan="99" align="center">工资明细</th>
                    </tr>
                    <tr>
                        <th>序号</th>
                        <th>姓名</th>
                        <th>国籍</th>
                        <th>证件编号</th>
                        <th>报税地</th>
                        <th>银行卡号</th>
                        <th>开户行</th>
                        <th>所属月份</th>
                        <th>工资类型</th>
                        <th>应发工资</th>
                        <th>应扣工资</th>
                        <th>税前工资</th>
                        <th>个税</th>
                        <th>实发工资</th>
                        <th>个人养老</th>
                        <th>个人医疗</th>
                        <th>个人失业</th>
                        <th>个人公积金</th>
                    </tr>
                    <tr ng-repeat="data in salaryList">
                        <td>{{$index + 1}}</td>
                        <td>{{data.userName}}</td>
                        <td>
                            <span ng-if="data.memberSalary.nationality == 0">非中国大陆</span>
                            <span ng-if="data.memberSalary.nationality == 1">中国大陆</span>
                        </td>
                        <td>{{data.certificateNumber}}</td>
                        <td>{{data.memberSalary.city.name}}</td>
                        <td>{{data.bankCard}}</td>
                        <td>{{data.bankName}}</td>
                        <td>{{data.month | date : "yyyyMM"}}</td>
                        <td>
                            <span ng-if="data.salaryTypeId == 0">工资</span>
                            <span ng-if="data.salaryTypeId == 1">年终奖</span>
                            <span ng-if="data.salaryTypeId == 2">劳务所得</span>
                            <span ng-if="data.salaryTypeId == 3">离职补偿金</span>
                        </td>
                        <td>{{data.shouldSendSalary}}</td>
                        <td>{{data.shouldBeDeductPay}}</td>
                        <td>{{data.salaryBeforeTax}}</td>
                        <td>{{data.individualIncomeTax}}</td>
                        <td>{{data.takeHomePay}}</td>
                        <td>{{data.pension}}</td>
                        <td>{{data.medical}}</td>
                        <td>{{data.unemployment}}</td>
                        <td>{{data.reserved}}</td>
                    </tr>
                    <tfoot ng-show="salaryList.length == 0"><tr><td colspan="99" class="not-data">暂无数据</td></tr></tfoot>
                </table>
            </div>
        </div>
        <div class="layui-tab-item" ng-if="businessInsuranceList.length > 0 || businessYc.length > 0">
            <div class="detail-div">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <th colspan="99" align="center">专项服务明细</th>
                    </tr>
                    <tr>
                        <th>序号</th>
                        <th>姓名</th>
                        <th>证件编号</th>
                        <th>服务起始年月</th>
                        <th>本次服务时长</th>
                        <th ng-repeat="item in businessItems">{{item.businessItem.itemName}}</th>
                    </tr>
                    <tr ng-repeat="data in businessInsuranceList">
                        <td>{{$index + 1}}</td>
                        <td>{{data.userName}}</td>
                        <td>{{data.certificateNum}}</td>
                        <td>{{data.serviceStartTime | date : "yyyyMM"}}</td>
                        <td>{{data.serviceEndTime | date : "yyyyMM"}}</td>
                        <td ng-repeat="item in data.businessInsuranceItemList">{{item.businessItem.price}}</td>
                    </tr>
                    <tfoot ng-show="businessInsuranceList.length == 0"><tr><td colspan="99" class="not-data">暂无数据</td></tr></tfoot>
                </table>

                <table border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;" ng-repeat="data in businessYc">
                    <tr>
                        <th colspan="99" style="text-align: left !important;">{{data.businessItemName}}</th>
                    </tr>
                    <tr>
                        <th>序号</th>
                        <th>姓名</th>
                        <th>证件编号</th>
                        <th>金额</th>
                    </tr>
                    <tr ng-repeat="item in data.businessYcItemList">
                        <td>{{$index + 1}}</td>
                        <td>{{item.userName}}</td>
                        <td>{{item.certificateNum}}</td>
                        <td>{{item.price}}</td>
                    </tr>
                    <tfoot ng-show="businessYcItemList.length == 0"><tr><td colspan="99" class="not-data">暂无数据</td></tr></tfoot>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="<%=request.getContextPath()%>/resources/js/jquery-2.1.0.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/config.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/angular.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/plugins/layui/lay/dest/layui.all.js"></script>

<script>

    var webApp = angular.module('webApp', []);
    webApp.controller("controller", function ($scope, $timeout) {
        $scope.companySonBillItemId = config.getUrlParam("companySonBillItemId"); // 子类账单ID  -- 暂无用
        $scope.companySonTotalBillId = config.getUrlParam("companySonTotalBillId"); // 账单汇总ID
        $scope.createTime = config.getUrlParam("createTime"); //创建时间
        $scope.companySonBillId = config.getUrlParam("companySonBillId"); //子账单配置ID -- 暂无用
        $scope.totalBill = []; //总账单
        $scope.socialSecurityList = []; //社保
        $scope.accumulationFundList = []; //公积金
        $scope.salaryList = []; //工资
        $scope.businessInsuranceList = []; //专项服务
        $scope.businessYc = []; //专项服务--体检
        $scope.businessItems = []; //专项服务--险种名称
        $scope.isShow = false;

        /**获取总账单**/
        $scope.getTheTotalBill = function () {
            config.ajaxRequestData(false, "h5Data/getTheTotalBillInfo", {
                companySonTotalBillId : $scope.companySonTotalBillId,
                createTime : $scope.createTime
            }, false, function (result) {
                if (result.code == 200) {
                    $scope.totalBill = result.data;
                    $scope.totalBill.payTime = new Date($scope.totalBill.payTime).getDate();

                    $scope.getSocialSecurity(); //社保
                    $scope.getAccumulationFund(); //公积金
                    $scope.getSalary(); //工资
                    $scope.getService(); //服务
                }
                else {
                    layer.alert(result.msg);
                }
            });
        }

        /**获取社保**/
        $scope.getSocialSecurity = function () {
            config.ajaxRequestData(false, "h5Data/getSocialSecurityInfo", {
                page : 0,
                pageSize : 9999,
                companySonBillItemId : $scope.companySonBillItemId,
                companySonTotalBillId : $scope.companySonTotalBillId,
            }, false, function (result) {
                if (result.code == 200) {
                    $scope.socialSecurityList = result.data;
                    $scope.companyInsuranceName = []; // 公司险种抬头
                    $scope.personInsuranceName = []; //个人险种抬头
                    for (var i = 0; i < $scope.socialSecurityList.length; i++) {
                        var obj = $scope.socialSecurityList[i];
                        for (var j = 0; j < obj.socialSecurityInfoItems.length; j++) {
                            var item = obj.socialSecurityInfoItems[j];
                            if (item.type == 0) {
                                $scope.companyInsuranceName.push(item);
                            }
                            else if (item.type == 1) {
                                $scope.personInsuranceName.push(item);
                            }
                        }
                    }
                    $scope.companyInsuranceName = unique($scope.companyInsuranceName);
                    $scope.personInsuranceName = unique($scope.personInsuranceName);
                }
                else {
                    layer.alert(result.msg);
                }
            });
        }

        /**获取公积金**/
        $scope.getAccumulationFund = function () {
            config.ajaxRequestData(false, "h5Data/getReservedFundsInfo", {
                page : 0,
                pageSize : 9999,
                companySonBillItemId : $scope.companySonBillItemId,
                companySonTotalBillId : $scope.companySonTotalBillId,
            }, false, function (result) {
                if (result.code == 200) {
                    $scope.accumulationFundList = result.data;
                }
                else {
                    layer.alert(result.msg);
                }
            });
        }

        /**获取工资**/
        $scope.getSalary = function () {
            config.ajaxRequestData(false, "h5Data/getSalaryInfo", {
                page : 0,
                pageSize : 9999,
                //companySonBillItemId : $scope.companySonBillItemId,
                companySonTotalBillId : $scope.companySonTotalBillId,
            }, false, function (result) {
                if (result.code == 200) {
                    $scope.salaryList = result.data;
                }
                else {
                    layer.alert(result.msg);
                }
            });
        }

        /**获取专项服务**/
        $scope.getService = function () {
            config.ajaxRequestData(false, "businessInsurance/getBusinessInsurance", {
                page : 0,
                pageSize : 9999,
                companySonTotalBillId : $scope.companySonTotalBillId,
            }, false, function (result) {
                if (result.code == 200) {
                    $scope.businessInsuranceList = result.data.businessInsurance;
                    $scope.businessYc = result.data.businessYc;
                    $scope.businessItems = result.data.businessItems;
                    //匹配险种
                    for (var i = 0; i < $scope.businessInsuranceList.length; i++) {
                        var item = $scope.businessInsuranceList[i];
                        item.business = [];
                        for (var j = 0; j < item.businessInsuranceItemList.length; j++) {
                            var item2 = item.businessInsuranceItemList[j];
                            for (var k = 0; k < $scope.businessItems.length; k++) {
                                var item3 = $scope.businessItems[k];
                                if (item3.id == item2.id) {
                                    item.business.push(item2);
                                }
                            }
                        }
                        $scope.businessItems = $scope.businessInsuranceList[0].business;
                    }
                }
                else {
                    layer.alert(result.msg);
                }
            });
        }

        /**驳回**/
        $scope.turnDown = function () {
            config.ajaxRequestData(false, "companySonBillItem/delete", {
                companySonTotalBillId : $scope.companySonTotalBillId,
                createTime : $scope.createTime
            }, true, function (result) {
                $(".btn-danger").hide();
                $(".btn-warm").hide();
                layer.msg("驳回账单成功");
            });
        }

        /**确认账单**/
        $scope.confirmTheBill = function () {
            config.ajaxRequestData(false, "companySonBillItem/updateStatus", {
                companySonTotalBillId : $scope.companySonTotalBillId,
            }, true, function (result) {
                $(".btn-danger").hide();
                $(".btn-warm").hide();
                $scope.isShow = true;
                layer.msg("确认账单成功");
            });
        }

        /**下载Excel**/
        $scope.downloadTheBill = function () {
            window.location.href = config.ip + "export/downLoad?companySonTotalBillId=" + $scope.companySonTotalBillId + "&createTime=" + $scope.createTime
        }

        $scope.getTheTotalBill(); //总账单
    });

    function unique(list){
        var arr = [];
        for(var i = 0; i < list.length; i++){
            if(i == 0) arr.push(list[i]);
            var b = false;
            if(arr.length > 0 && i > 0){
                for(var j = 0; j < arr.length; j++){
                    if(arr[j].insuranceName == list[i].insuranceName){
                        b = true;
                        //break;
                    }
                }
                if(!b){ arr.push(list[i]);}
            }
        }
        return arr;
    }

</script>
</body>
</html>
