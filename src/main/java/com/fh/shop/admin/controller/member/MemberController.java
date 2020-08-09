package com.fh.shop.admin.controller.member;

import com.fh.shop.admin.biz.member.IMemberService;
import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.param.member.MemberSearchParam;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Resource(name = "memberService")
    private IMemberService memberService;

    @RequestMapping("/toList")
    public String toList(){

        return "/member/list";
    }

    @RequestMapping("/queryMemberList")
    @ResponseBody
    public DataTableResult queryMemberList(MemberSearchParam memberSearchParam){

        return memberService.queryMemberList(memberSearchParam);
    }
}
