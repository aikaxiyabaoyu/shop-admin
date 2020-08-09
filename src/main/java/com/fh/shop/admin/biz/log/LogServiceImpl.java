package com.fh.shop.admin.biz.log;

import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.mapper.log.ILogMapper;
import com.fh.shop.admin.param.log.LogSearchParam;
import com.fh.shop.admin.po.log.Log;
import com.fh.shop.admin.util.DateUtil;
import com.fh.shop.admin.vo.log.LogVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("logService")
public class LogServiceImpl implements ILogService{

    @Autowired
    private ILogMapper logMapper;

    @Override
    public void addLog(Log log) {
        logMapper.insert(log);
    }

    @Override
    public DataTableResult queryLogList(LogSearchParam logSearchParam) {
        //查询总条数
        Long total = logMapper.queryCount(logSearchParam);

        //查询分页数据
        List<Log> list = logMapper.queryLogList(logSearchParam);

        //Po转Vo
        List<LogVo> logVoList = new ArrayList<>();
        for (Log log : list) {
            LogVo logVo = new LogVo();
            logVo.setLogId(log.getLogId());
            logVo.setUserName(log.getUserName());
            logVo.setRealName(log.getRealName());
            logVo.setInfo(log.getInfo());
            logVo.setContent(log.getContent());
            logVo.setStatus(log.getStatus());
            logVo.setParamInfo(log.getParamInfo());
            logVo.setInsertTime(DateUtil.date2string(log.getInsertTime(),DateUtil.Y_M_D_H_M_S));
            logVoList.add(logVo);
        }

        return new DataTableResult(logSearchParam.getDraw(),total,total,logVoList);
    }
}
