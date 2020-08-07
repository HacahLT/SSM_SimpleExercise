package cn.atguigu.test;

import cn.atguigu.dao.DepartmentMapper;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;

/**
 * @author Hacah
 * @date 2020/7/25 14:16
 * 测试Dao层是否可行
 */
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {




    public void testDept() {
        /*//1.创建SpringIOC容器
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
        //2.获取Bean
        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
    }

}
