package com.fh.shop.admin.biz.standard;

import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.PageBean;

public interface IStandardService {
    ServerResponse addStandard(String standardNameStr, String standardSortStr, String standardValueStr);

    DataTableResult queryStandardList(PageBean pageBean);

    ServerResponse deleteStandard(Long id);
}
