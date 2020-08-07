import cn.atguigu.dao.DepartmentMapper;
import cn.atguigu.dao.EmployeeMapper;
import cn.atguigu.domain.Department;
import cn.atguigu.domain.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @author Hacah
 * @date 2020/7/25 14:16
 * 测试Dao层是否可行
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testDept() {
        /*//1.创建SpringIOC容器
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
        //2.获取Bean
        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/

        //测试是否可以获取departmentMapper
        System.out.println(departmentMapper);

        //1.添加几个部门
        //departmentMapper.insertSelective(new Department(null,"开发部"));
        //departmentMapper.insertSelective(new Department(null,"测试部"));

        //2.添加几个员工
        //employeeMapper.insertSelective(new Employee(null, "张", "男", "1521542154", 16, null));
        //3.批量插入多个员工
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uuid = UUID.randomUUID().toString().substring(0, 5)+i;
            employeeMapper.insertSelective(new Employee(null,uuid,"女",uuid+"@QQccd",16,null));
        }
        //4.删除员工
       /* for (int i = 1000;i<1003;i++) {
            employeeMapper.deleteByPrimaryKey(i);
            System.out.println("删除了主键为"+i+"的员工");
        }*/
    }

}
