package com.fh.shop.admin.biz.user;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.User.IUserMapper;
import com.fh.shop.admin.param.user.UserSearchParam;
import com.fh.shop.admin.po.user.User;
import com.fh.shop.admin.util.DateUtil;
import com.fh.shop.admin.vo.user.UserVo;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.io.IOException;
import java.io.StringWriter;
import java.util.*;

@Service("userService")
public class UserServiceImpl implements IUserService{

    @Autowired
    private IUserMapper userMapper;

    @Override
    public Map queryUserList(UserSearchParam userSearchParam) {
        Map result = new HashMap();
        Long total = userMapper.queryCount(userSearchParam);

        List<User> userPoList = userMapper.queryUserList(userSearchParam);
        List<UserVo> userVoList = new ArrayList<>();

        for(int i = 0; i < userPoList.size(); i++){
            User userPo = userPoList.get(i);
            UserVo userVo = new UserVo();

            userVo.setUserId(userPo.getUserId());
            userVo.setUserName(userPo.getUserName());
            userVo.setRealName(userPo.getRealName());
            userVo.setPassword(userPo.getPassword());
            userVo.setSex(userPo.getSex());
            userVo.setUserEmail(userPo.getUserEmail());
            userVo.setPhoneNumber(userPo.getPhoneNumber());
            userVo.setFileName(userPo.getFileName());
            userVo.setBirthday(DateUtil.date2string(userPo.getBirthday(),DateUtil.Y_M_D));
            userVo.setShengName(userPo.getShengName());
            userVo.setShiName(userPo.getShiName());
            userVo.setXianName(userPo.getXianName());
            userVo.setAreaNames(userPo.getShengName() + "==>" + userPo.getShiName() + "==>" + userPo.getXianName());

            userVoList.add(userVo);
        }

        result.put("data",userVoList);
        result.put("draw",userSearchParam.getDraw());
        result.put("recordsTotal",total);
        result.put("recordsFiltered",total);
        return result;
    }

    @Override
    public ServerResponse addUser(User user) {
        if(!StringUtils.isEmpty(user.getFileName())){
            user.setFileName(user.getFileName().substring(0,user.getFileName().length()-1));
        }

        userMapper.insert(user);

        return ServerResponse.success();
    }

    @Override
    public ServerResponse deleteUser(Long id) {
        userMapper.deleteById(id);

        return ServerResponse.success();
    }

    @Override
    public UserVo queryUserById(Long id) {
        User userPo = userMapper.queryUserById(id);
        UserVo userVo = new UserVo();
        userVo.setUserId(userPo.getUserId());
        userVo.setUserName(userPo.getUserName());
        userVo.setRealName(userPo.getRealName());
        userVo.setPassword(userPo.getPassword());
        userVo.setSex(userPo.getSex());
        userVo.setUserEmail(userPo.getUserEmail());
        userVo.setPhoneNumber(userPo.getPhoneNumber());
        userVo.setFileName(userPo.getFileName());
        userVo.setBirthday(DateUtil.date2string(userPo.getBirthday(),DateUtil.Y_M_D));
        userVo.setShengId(userPo.getShengId());
        userVo.setShiId(userPo.getShiId());
        userVo.setXianId(userPo.getXianId());
        userVo.setAreaNames(userPo.getShengName() + "==>" + userPo.getShiName() + "==>" + userPo.getXianName());

        return userVo;
    }

    @Override
    public ServerResponse updateUser(User user) {
        if(!StringUtils.isEmpty(user.getNewFileName())){
            user.setFileName(user.getFileName().substring(0,user.getFileName().length()-1));
        }

        userMapper.updateById(user);

        return ServerResponse.success();
    }

    @Override
    public User queryUserByName(String userName) {

        return userMapper.queryUserByName(userName);
    }

    @Override
    public List<User> queryUserListAll(UserSearchParam userParam) {
        List<User> userList = userMapper.queryUserListAll(userParam);

        for (int i = 0; i < userList.size(); i++) {
            User user = userList.get(i);
            user.setAreaNames(user.getShengName() + "==>" + user.getShiName() + "==>" + user.getXianName());
        }

        return userList;
    }

    @Override
    public StringWriter getStringWriter(List<User> userList) {
        Configuration configuration = new Configuration();
        configuration.setDefaultEncoding("utf-8");
        configuration.setClassForTemplateLoading(this.getClass(),"/template");

        StringWriter stringWriter = new StringWriter();
        try {
            Template template = configuration.getTemplate("userTemplate.html");
            Map result = new HashMap();
            result.put("userList",userList);
            template.process(result,stringWriter);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (TemplateException e) {
            e.printStackTrace();
        }

        return stringWriter;
    }

    @Override
    public void updateLoginTime(Long userId, Date date) {
        User user = new User();
        user.setUserId(userId);
        user.setLoginTime(date);
        userMapper.updateById(user);
    }

    @Override
    public void updateLoginCount(Long userId) {
        User user = new User();
        user.setUserId(userId);
        user.setLoginCount(1);
        userMapper.updateById(user);
    }

    @Override
    public void inscLoginCount(Long userId) {

        userMapper.inscLoginCount(userId);
    }

    @Override
    public void updateErrorCount(Long userId, Date date) {

        userMapper.updateErrorCount(userId,date);
    }

    @Override
    public void clearErrorCount(Long userId, Date date) {
        User user = new User();
        user.setUserId(userId);
        user.setErrorTime(date);
        userMapper.updateById(user);
    }
}