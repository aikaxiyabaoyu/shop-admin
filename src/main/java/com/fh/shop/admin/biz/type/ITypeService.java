package com.fh.shop.admin.biz.type;

import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.PageBean;

public interface ITypeService {
    ServerResponse initTables();

    ServerResponse addType(String typeName, String brandIds, String standardIds);

    DataTableResult queryTypeList(PageBean pageBean);
}
