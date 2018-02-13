package com.magic.daoyuan.web.controller;

import com.magic.daoyuan.business.service.TradeService;
import com.magic.daoyuan.business.util.StatusConstant;
import com.magic.daoyuan.web.util.ViewData;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * Created by Eric Xie on 2017/9/12 0012.
 */
@RestController
@RequestMapping("/trade")
public class TradeController extends BaseController {

    @Resource
    private TradeService tradeService;

    /**
     * 获取所有的行业
     * @return
     */
    @RequestMapping("/queryAllTrade")
    public ViewData queryAllTrade(){
        return buildSuccessJson(StatusConstant.SUCCESS_CODE,"获取成功",
                tradeService.queryAllTrade(null));
    }

}
