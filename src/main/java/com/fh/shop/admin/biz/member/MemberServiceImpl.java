package com.fh.shop.admin.biz.member;

import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.mapper.member.IMemberMapper;
import com.fh.shop.admin.param.member.MemberSearchParam;
import com.fh.shop.admin.po.member.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("memberService")
public class MemberServiceImpl implements IMemberService{

    @Autowired
    private IMemberMapper memberMapper;

    @Override
    public DataTableResult queryMemberList(MemberSearchParam memberSearchParam) {
        Long total = memberMapper.queryTotal(memberSearchParam);

        List<Member> list = memberMapper.queryMemberList(memberSearchParam);

        return new DataTableResult(memberSearchParam.getDraw(),total,total,list);
    }
}
