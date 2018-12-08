package hibernate_test.json;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import hibernate_test.HibernateUtil;
import model.BeanDrug;
import org.hibernate.Session;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TagCloudJsonGenerate {
    public static void createJson() {
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


        ObjectMapper objectMapper = new ObjectMapper();
        for (Map.Entry<String, Integer> a: tagMap.entrySet()){
//            System.out.println(a.getKey());
//            System.out.println(a.getValue());
            ObjectNode objectNode = objectMapper.createObjectNode();
            objectNode.put(a.getKey(), a.getValue());
        }
//        String result = objectMapper.writeValueAsString();



        session.close();
    }

    public static void main(String[] args) {
        createJson();
    }
}
