package com.fh.shop.admin.mapper.member;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.admin.param.member.MemberSearchParam;
import com.fh.shop.admin.po.member.Member;

import java.util.List;

public interface IMemberMapper extends BaseMapper<Member> {
    Long queryTotal(MemberSearchParam memberSearchParam);

    List<Member> queryMemberList(MemberSearchParam memberSearchParam);
}
