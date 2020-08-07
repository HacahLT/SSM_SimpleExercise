package cn.atguigu.controller;

import cn.atguigu.domain.Employee;
import cn.atguigu.domain.Msg;
import cn.atguigu.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Hacah
 * @date 2020/7/27 16:30
 * 处理员工的CRUD操作
 */

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 多个删除或单个删除
     * 多个：id-id-id
     * 单个：id
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
    public Msg delEmpById(@PathVariable("id") String ids) {
        if (ids.contains("-")) {
            //多个id，批量删除
            List<Integer> list = new ArrayList<Integer>();
            String[] str_ids = ids.split("-");
            for (String id : str_ids) {
                list.add(Integer.parseInt(id));
            }
            employeeService.delBatch(list);
        }else {
            //单个id
            int id = Integer.parseInt(ids);
            employeeService.delEmpById(id);
        }
        return Msg.success();
    }

    /**
     * 更新员工方法
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee) {
        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 根据id查询员工
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id")Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().addInfo("emp",employee);
    }


    /**
     * 检测用户名是否可用
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkUserName")
    public Msg checkUserName(@RequestParam("empName") String empName) {
        if (empName == null || empName==""){
            return null;
        }
        //判断用户名是否合法
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regx)){
            return Msg.fail().addInfo("val_msg","用户名必须是6-16位英文字符或者2-5位中文");
        }
        //用户名是否可用校验
        Boolean flag = employeeService.checkUserName(empName);
        if (flag){
            return Msg.success();
        }else {
            return Msg.fail().addInfo("val_msg","用戶名不可用。已存在。");
        }
    }
    /**
     * 员工保存
     * @return
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()){
            //校验失败
            Map<String,Object> map = new HashMap();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError:fieldErrors) {
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().addInfo("errorfields",map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 查询员工数据
     *   AJAX技术
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        //使用pagehelper分页查询插件,在查询前进行分页,第几页，有多少条内容
        PageHelper.startPage(pn, 10);
        List<Employee> emps = employeeService.getAll();
        //使用pageinfo包装查询后的结果,传入查询的数据和连续显示的页数
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().addInfo("pageInfo",page);
    }

    /**
     * 查询员工数据
     *
     * @return
     */
    //@RequestMapping("/emps")
    public String getAllEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //使用pagehelper分页查询插件,在查询前进行分页,第几页，有多少条内容
        PageHelper.startPage(pn, 10);
        List<Employee> emps = employeeService.getAll();
        //使用pageinfo包装查询后的结果,传入查询的数据和连续显示的页数
        PageInfo page = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", page);
        return "list";
    }
}
