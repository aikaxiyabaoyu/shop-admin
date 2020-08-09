package com.fh.shop.admin.controller.user;

import com.fh.shop.admin.annocation.Log;
import com.fh.shop.admin.biz.user.IUserService;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.common.UserEnum;
import com.fh.shop.admin.param.user.UserSearchParam;
import com.fh.shop.admin.po.user.User;
import com.fh.shop.admin.util.DateUtil;
import com.fh.shop.admin.util.ExcelUtil;
import com.fh.shop.admin.util.FileUtil;
import com.fh.shop.admin.util.Upload;
import com.fh.shop.admin.vo.user.UserVo;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.StringWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Resource(name = "userService")
    private IUserService userService;

    @RequestMapping("/toList")
    public String toList(){

        return "/user/list";
    }

    @RequestMapping("/queryUserList")
    @ResponseBody
    public Map queryUserList(UserSearchParam userSearchParam){

        return userService.queryUserList(userSearchParam);
    }

    @RequestMapping("/addUser")
    @ResponseBody
    @Log(info = "新增用户")
    public ServerResponse addUser(User user){

        return userService.addUser(user);
    }

    @RequestMapping("/deleteUser")
    @ResponseBody
    @Log(info = "删除用户")
    public ServerResponse deleteUser(Long id,HttpServletRequest request){
        UserVo userVo = userService.queryUserById(id);

        //调用删除图片的工具类
        Upload.deleteImage(userVo.getFileName(),request);
        
        return userService.deleteUser(id);
    }

    @RequestMapping("/queryUserById")
    @ResponseBody
    public ServerResponse queryUserById(Long id){
        UserVo userVo = userService.queryUserById(id);

        return ServerResponse.success(userVo);
    }

    @RequestMapping("/updateUser")
    @ResponseBody
    @Log(info = "修改用户")
    public ServerResponse updateUser(User user, HttpServletRequest request){
        if(!StringUtils.isEmpty(user.getNewFileName())){
            //调用删除图片的工具类
            Upload.deleteImage(user.getFileName(),request);

            user.setFileName(user.getNewFileName());
        }

        return userService.updateUser(user);
    }

    //导出Excel
    @RequestMapping("exportExcel")
    public void exportExcel(UserSearchParam userParam, HttpServletResponse response){
        //1.根据查询条件查询出符合条件的商品信息（注意是所有符合条件的数据，且不需要分页，因此不能直接调用条件查询的方法）
        List<User> userList = userService.queryUserListAll(userParam);

        //2.运用java反射机制 将数据转换为excel数据
        String[] headerNames = {"用户id","用户名称","真实姓名","用户生日","手机号码","电子邮箱","用户地区"};
        String[] props = {"userId","userName","realName","birthday","phoneNumber","userEmail","areaNames"};
        XSSFWorkbook workbook = ExcelUtil.getWorkbook(userList,"用户列表",headerNames,props);

        //3.调用工具类中下载excel文件方法
        //如下是以下载的方式，返回给客户端，而不是保存的形式，如 workbook.write(new FileOutputStream("d:/商品列表.xlsx"));
        FileUtil.excelDownload(workbook,response);
    }

    //导出pdf
    @RequestMapping("exportPdf")
    public void exportPdf(UserSearchParam userSearchParam, HttpServletRequest request, HttpServletResponse response){
        List<User> userList = userService.queryUserListAll(userSearchParam);

        StringWriter stringWriter = userService.getStringWriter(userList);

        FileUtil.pdfDownloadFile(response,stringWriter.toString());
    }

    @RequestMapping("/login")
    @ResponseBody
    @Log(info = "用户登录")
    public ServerResponse login(HttpSession session, String userName, String password){
        if(StringUtils.isEmpty(userName) || StringUtils.isEmpty(password)){
            //用户名或密码不能为空！
            return ServerResponse.error(UserEnum.USERNAME_PASSWORD_IS_NULL);
        }
        User userDB = userService.queryUserByName(userName);
        if(userDB == null){
            //用户不存在！
            return ServerResponse.error(UserEnum.USER_IS_NOT_HAVE);
        }
        //如果错误时间是空的话 有两种情况
        //一种是密码一次都没输错过的用户 还有一种是第二天清空的用户
        if(userDB.getErrorTime() != null){
            //将错误时间和当前时间转为年月日格式
            Date oldErrorDate = DateUtil.string2date(DateUtil.date2string(userDB.getErrorTime(), DateUtil.Y_M_D), DateUtil.Y_M_D);
            Date newErrorDate = DateUtil.string2date(DateUtil.date2string(new Date(), DateUtil.Y_M_D), DateUtil.Y_M_D);
            //当当前时间距离最后一次输错密码时间已经一天的时候 清空错误次数和时间
            if(newErrorDate.after(oldErrorDate)){
                userService.clearErrorCount(userDB.getUserId(),null);
            }
        }
        if(userDB.getErrorCount() == 3){
            //输错密码超过三次
            return ServerResponse.error(UserEnum.USER_IS_LOCKED);
        }
        if(!password.equals(userDB.getPassword())){
            //密码错误！
            userService.updateErrorCount(userDB.getUserId(),new Date());
            return ServerResponse.error(UserEnum.PASSWORD_IS_ERROR);
        }

        Date loginTime = userDB.getLoginTime();
        //当loginTime是空的时候 说明用户是第一次登陆
        //若是不加这个if判断 会空指针
        if(loginTime == null){
            userDB.setLoginCount(1);
            userService.updateLoginCount(userDB.getUserId());
        }else {
            //将loginTime转为年月日格式 将当前时间也转为年月日格式
            Date oldDate = DateUtil.string2date(DateUtil.date2string(loginTime, DateUtil.Y_M_D), DateUtil.Y_M_D);
            Date newDate = DateUtil.string2date(DateUtil.date2string(new Date(), DateUtil.Y_M_D), DateUtil.Y_M_D);
            //当当前时间在loginTime之后的时候 说明已经是第二天了
            if(newDate.after(oldDate)){

                userDB.setLoginCount(1);
                userService.updateLoginCount(userDB.getUserId());
            }else {
                userDB.setLoginCount(userDB.getLoginCount()+1);
                userService.inscLoginCount(userDB.getUserId());
            }
        }

        session.setAttribute("user",userDB);

        userService.updateLoginTime(userDB.getUserId(),new Date());

        return ServerResponse.success();
    }

    //注销用户
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request){
        request.getSession().removeAttribute("user");

        return "../../login";
    }
}
