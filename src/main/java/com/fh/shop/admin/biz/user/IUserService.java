package com.fh.shop.admin.biz.user;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.user.UserSearchParam;
import com.fh.shop.admin.po.user.User;
import com.fh.shop.admin.vo.user.UserVo;

import java.io.StringWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;

public interface IUserService {

    Map queryUserList(UserSearchParam userSearchParam);

    ServerResponse addUser(User user);

    ServerResponse deleteUser(Long id);

    UserVo queryUserById(Long id);

    ServerResponse updateUser(User user);

    User queryUserByName(String userName);

    List<User> queryUserListAll(UserSearchParam userParam);

    StringWriter getStringWriter(List<User> userList);

    void updateLoginTime(Long userId, Date date);

    void updateLoginCount(Long userId);

    void inscLoginCount(Long userId);

    void updateErrorCount(Long userId, Date date);

    void clearErrorCount(Long userId, Date date);
}
