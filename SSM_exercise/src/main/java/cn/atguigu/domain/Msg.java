package cn.atguigu.domain;

import com.github.pagehelper.PageInfo;

import java.util.HashMap;
import java.util.Map;

/**
 * @author Hacah
 * @date 2020/7/29 18:25
 * 作为一个包含状态的返回数据的bean
 */
public class Msg {

    /**状态，true为成功*/
    private boolean stat;
    /**提示信息是否成功*/
    private String msg;
    /**服务器返回浏览器的数据*/
    private Map<String,Object> extend = new HashMap<String, Object>();

    /**
     * 成功方法
     * @return
     */
    public static Msg success() {
        Msg msg = new Msg();
        msg.setStat(true);
        msg.setMsg("处理成功！");
        return msg;
    }

    /**
     * 失败方法
     * @return
     */
    public static Msg fail() {
        Msg msg = new Msg();
        msg.setStat(false);
        msg.setMsg("处理失败！");
        return msg;
    }

    /**
     * 添加PageInfo对象的方法
     * @return
     */
    public Msg addInfo(String key,Object ob) {
        this.getExtend().put(key,ob);
        return this;
    }

    public boolean isStat() {
        return stat;
    }

    public void setStat(boolean stat) {
        this.stat = stat;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
