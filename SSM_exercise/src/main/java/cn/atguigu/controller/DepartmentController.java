package cn.atguigu.controller;

import cn.atguigu.domain.Department;
import cn.atguigu.domain.Msg;
import cn.atguigu.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author Hacah
 * @date 2020/8/1 18:16
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;


    /**
     * 返回所有部门
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts() {
        List<Department> list = departmentService.getDepts();
        return Msg.success().addInfo("depts",list);
    }
}
