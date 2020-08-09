package com.fh.shop.admin.common;

public enum UserEnum {
    USERNAME_PASSWORD_IS_NULL(7000,"用户名和密码不能为空！"),
    USER_IS_NOT_HAVE(7001,"用户不存在！"),
    PASSWORD_IS_ERROR(7002,"密码错误！"),
    USER_IS_LOCKED(7003,"输错密码超过三次，请明天再试！"),
    ;

    private int code;

    private String message;

    private UserEnum(int code,String message) {
        this.code = code;
        this.message = message;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
