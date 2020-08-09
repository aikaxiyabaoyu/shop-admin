package com.fh.shop.admin.common;

import java.io.Serializable;

public class ServerResponse implements Serializable {

    private Integer code;

    private String message;

    private Object data;

    private ServerResponse(){

    }

    private ServerResponse(Integer code,String message,Object data){
        this.code = code;
        this.message = message;
        this.data = data;
    }

    public static ServerResponse success(){

        return new ServerResponse(200,"ok",null);
    }

    public static ServerResponse success(Object data){

        return new ServerResponse(200,"ok",data);
    }

    public static ServerResponse error(){

        return new ServerResponse(500,"error",null);
    }

    public static ServerResponse error(UserEnum userEnum){

        return new ServerResponse(userEnum.getCode(),userEnum.getMessage(),null);
    }

    public Integer getCode() {
        return code;
    }

    public Object getData() {
        return data;
    }

    public String getMessage() {
        return message;
    }
}
