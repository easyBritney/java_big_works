package hibernate_test;

import model.BeanDrug;
import org.hibernate.Query;
import org.hibernate.Session;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DrugManager {
    public void CreateDrugs(BeanDrug drug) throws BaseException {
        Session session = HibernateUtil.getSession();
        session.beginTransaction();

        if(drug==null)
            throw new BaseException("null");

        session.save(drug);

        session.getTransaction().commit();
        session.close();
    }
    public static List<BeanDrug> loadAllDrugs() throws BaseException {
        List<BeanDrug> list=new ArrayList<>();
        try{
            Session session=HibernateUtil.getSession();
            session.beginTransaction();
            String hql="From BeanDrug";
            Query qry = session.createQuery(hql);
            list=qry.list();
            session.getTransaction().commit();
            session.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return list;
    }
    public static Map<String,Float> loadAllDrugWeigh() throws BaseException {
        Map<String,Float> map=new HashMap<>() ;
        List<BeanDrug> list=loadAllDrugs();
        map.put("甲基苯丙胺",0.0f);
        map.put("冰毒", 0.0f);
        map.put("海洛因", 0.0f);
        map.put("大麻",0.0f);
        map.put("吗啡", 0.0f);

        map.put("卡洛因", 0.0f);
        map.put("卡西酮",0.0f);
        map.put("鸦片", 0.0f);
        map.put("K粉", 0.0f);
        map.put("摇头丸",0.0f);

        map.put("杜冷丁", 0.0f);
        map.put("古柯", 0.0f);
        map.put("咖啡因",0.0f);
        map.put("三唑仑", 0.0f);
        map.put("羟基丁酸", 0.0f);

        try{
            float value;
            for(BeanDrug drug:list){
                // System.out.println(drug.getDrugType());
                value= map.get(drug.getDrugType());
                map.put(drug.getDrugType(), value+drug.getDrugNum());
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return map;
    }
    public static void main(String[] args) throws IOException {
        try{
            Map<String,Float> map1=DrugManager.loadAllDrugWeigh();
            System.out.println(map1);
        }
        catch (Exception e){

        }
    }
}
