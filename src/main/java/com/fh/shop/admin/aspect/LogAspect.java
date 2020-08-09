package com.fh.shop.admin.aspect;

import com.fh.shop.admin.biz.log.ILogService;
import com.fh.shop.admin.common.WebContext;
import com.fh.shop.admin.po.log.Log;
import com.fh.shop.admin.po.user.User;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;

public class LogAspect {

    public static final Logger LOGGER = LoggerFactory.getLogger(LogAspect.class);

    @Resource(name = "logService")
    private ILogService logService;

    public Object doLog(ProceedingJoinPoint pjp){
        Object proceed;

        //获取类名
        String canonicalName = pjp.getTarget().getClass().getCanonicalName();
        //获取方法的切名
        MethodSignature methodSignature = (MethodSignature) pjp.getSignature();
        //获取类中的方法
        Method method = methodSignature.getMethod();
        //获取类中方法名
        String name = pjp.getSignature().getName();
        //获取threadLocal中存储的request
        HttpServletRequest request = WebContext.get();
        //获取到request中的参数
        Map<String, String[]> parameterMap = request.getParameterMap();
        //获取参数map集合中的entry对象并放入迭代器中
        Iterator<Map.Entry<String, String[]>> iterator = parameterMap.entrySet().iterator();
        //创建一个StringBuffer用来存储参数
        StringBuffer stringBuffer = new StringBuffer();
        //如果迭代器中有下一个元素的话
        while(iterator.hasNext()){
            //获取下一个元素
            Map.Entry<String, String[]> next = iterator.next();
            //获取元素中的key
            String key = next.getKey();
            //获取元素中的value
            String[] value = next.getValue();
            //给StringBuffer赋值
            stringBuffer.append(key).append(":").append(StringUtils.join(value)).append("|");
        }
        //获取session中存储的user对象
        User user = (User) request.getSession().getAttribute("user");
        try {

            //执行真正的方法
            proceed = pjp.proceed();
            //获取session中存储的user对象
            user = (User) request.getSession().getAttribute("user");

            //当执行完核心业务逻辑之后user还是空的话
            //就说明走的是登录方法 并且没有登录成功 直接return
            if(user == null){
                return proceed;
            }

            //打印日志
            LOGGER.info(user.getRealName()+"访问"+canonicalName+"中的"+name+"方法成功");

            //将日志信息插入至数据库
            Log log = new Log();
            //如果方法上有log注解的话
            if(method.isAnnotationPresent(com.fh.shop.admin.annocation.Log.class)){
                //获取方法上的log注解
                com.fh.shop.admin.annocation.Log logAnnotation = method.getAnnotation(com.fh.shop.admin.annocation.Log.class);
                //将注解中的info赋给Log对象
                log.setContent(logAnnotation.info());
            }
            log.setUserName(user.getUserName());
            log.setRealName(user.getRealName());
            log.setInsertTime(new Date());
            log.setInfo("访问"+canonicalName+"中的"+name+"方法成功");
            log.setStatus(1);
            log.setParamInfo(stringBuffer.toString());
            logService.addLog(log);

            return proceed;
        } catch (Throwable throwable) {
            //在控制台打印异常
            throwable.printStackTrace();

            //打印日志
            LOGGER.error(user.getRealName()+"访问"+canonicalName+"中的"+name+"方法失败");

            //将日志信息插入至数据库
            Log log = new Log();
            //如果方法上有log注解的话
            if(method.isAnnotationPresent(com.fh.shop.admin.annocation.Log.class)){
                //获取方法上的log注解
                com.fh.shop.admin.annocation.Log logAnnotation = method.getAnnotation(com.fh.shop.admin.annocation.Log.class);
                //将注解中的info赋给Log对象
                log.setContent(logAnnotation.info());
            }
            log.setUserName(user.getUserName());
            log.setRealName(user.getRealName());
            log.setInsertTime(new Date());
            log.setInfo("访问"+canonicalName+"中的"+name+"方法失败");
            log.setStatus(2);
            log.setParamInfo(stringBuffer.toString());
            logService.addLog(log);

            //抛出此异常
            throw new RuntimeException(throwable);
        }
    }

}
