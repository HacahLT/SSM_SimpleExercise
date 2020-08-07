package cn.atguigu.service;

import cn.atguigu.dao.EmployeeMapper;
import cn.atguigu.domain.Employee;
import cn.atguigu.domain.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Hacah
 * @date 2020/7/27 16:36
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询出所有员工数据
     * @return
     */
    public List<Employee> getAll() {
        List<Employee> emps = employeeMapper.selectByExampleWithDept(null);
        return emps;
    }

    /**
     * 保存员工
     * @param employee
     */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     * 检测用户名是否可用
     * @param empName
     * @return true代表可用
     */
    public Boolean checkUserName(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    /**
     * 根据id查询员工
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKeyWithDept(id);
        return employee;
    }

    /**
     * 更新员工信息
     * @param employee
     */
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 删除员工方法
     * @param id
     */
    public void delEmpById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void delBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
