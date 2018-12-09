package hibernate_test.json;

import com.fasterxml.jackson.databind.ObjectMapper;
import hibernate_test.HibernateUtil;
import model.BeanCrime;
import model.BeanDrug;
import org.hibernate.Session;
import org.omg.CORBA.INTERNAL;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class VerticalBPJsonGenerate {
    public static void createJson() throws IOException {
        Session session = HibernateUtil.getSession();
        String hql = "from BeanDrug ";
        List<BeanDrug> drugs = session.createQuery(hql).list();


        Map<String, Map<String, Integer>> data = new HashMap<>();

        for(BeanDrug a: drugs){
            if(a.getBeanCrime().getArea() == null)
                continue;
            if(data.containsKey(a.getDrugType())){
                if(data.get(a.getDrugType()).containsKey(a.getBeanCrime().getArea())){
                    data.get(a.getDrugType()).put(a.getBeanCrime().getArea(), data.get(a.getDrugType()).get(a.getBeanCrime().getArea()) + 1);
                }
                else{
                    data.get(a.getDrugType()).put(a.getBeanCrime().getArea(), 1);
                }
            }
            else{
                Map<String, Integer> map = new HashMap<>();
                map.put(a.getBeanCrime().getArea(), 1);
                data.put(a.getDrugType(), map);
            }
        }

//        for(Map.Entry a: data.entrySet()){
//            for(Map.Entry b: ((Map<String, Integer>)a.getValue()).entrySet()){
//                System.out.println(a.getKey());
//                System.out.println(b.getKey());
//                System.out.println(b.getValue());
//            }
//        }

        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.writeValue(new File("C:/source/javabigwork/out/artifacts/javabigwork_war_exploded/data/verticalBP.json"), data);
//        System.out.println(objectMapper.writeValueAsString(data));
        session.close();

    }

    public static void main(String[] args) throws IOException {
        createJson();
    }
}
