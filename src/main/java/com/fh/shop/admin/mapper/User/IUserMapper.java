package com.fh.shop.admin.mapper.User;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.admin.param.user.UserSearchParam;
import com.fh.shop.admin.po.user.User;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface IUserMapper extends BaseMapper<User> {
    Long queryCount(UserSearchParam userSearchParam);

    List<User> queryUserList(UserSearchParam userSearchParam);

    User queryUserById(Long id);

    User queryUserByName(String userName);

    List<User> queryUserListAll(UserSearchParam userParam);

    void inscLoginCount(Long userId);

    void updateErrorCount(@Param("userId")Long userId, @Param("date")Date date);

}
