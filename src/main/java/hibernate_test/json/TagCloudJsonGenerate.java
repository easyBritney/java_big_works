package hibernate_test.json;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import hibernate_test.HibernateUtil;
import javafx.util.Pair;
import model.BeanDrug;
import org.hibernate.Session;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TagCloudJsonGenerate {
    public static void createJson() throws IOException {
        Session session = HibernateUtil.getSession();
        String hql = "from BeanDrug ";

        List<BeanDrug> drugs = session.createQuery(hql).list();
        Map<String, Integer> tagMap = new HashMap<String, Integer>();
        for(BeanDrug a: drugs){
//            System.out.println(a.getDrugType());
            if(!tagMap.containsKey(a.getDrugType()))
                tagMap.put(a.getDrugType(), 1);
            else
                tagMap.put(a.getDrugType(), 1 + tagMap.get(a.getDrugType()));
        }


        ArrayList<BeanTagCloud> data = new ArrayList<BeanTagCloud>();

        BeanTagCloud beanTagCloud;
//        beanTagCloud.setDrug("Hello");
//        beanTagCloud.setSize(2);


        for(Map.Entry a: tagMap.entrySet()){
            beanTagCloud = new BeanTagCloud();
            beanTagCloud.setDrug((String)a.getKey());
            beanTagCloud.setSize((Integer)a.getValue());
            beanTagCloud.setHref("https://baike.baidu.com/item/" + a.getKey());


            data.add(beanTagCloud);
        }

        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.writeValue(new File("C:/source/javabigwork/out/artifacts/javabigwork_war_exploded/data/tagCloud.json"), data);
        session.close();
    }

    public static void main(String[] args) throws IOException {
        createJson();
    }
}
