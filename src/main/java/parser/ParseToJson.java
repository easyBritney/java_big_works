package parser;

import com.sun.javafx.font.PrismFontFactory;
import hibernate_test.*;
import model.BeanCase;
import model.BeanCrime;
import model.BeanPrisoner;
import org.hibernate.Query;
import org.hibernate.Session;
import tools.Txt;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class ParseToJson {

    public static void ParseToJson(Map<String, BeanPrisoner> prisonerMap, List<BeanCase> cases, String savePath, String saveName) {

        String nodes = "\"nodes\":[ ";
        String links = "\"links\":[ ";

        System.out.println(prisonerMap.keySet());
        for (String name : prisonerMap.keySet()) {
            String birthTime = ParseToCsv.formatTime(prisonerMap.get(name).getBirth());
            String crimeTime = ParseToCsv.formatTime(prisonerMap.get(name).getBeanCrime().getDate());
            nodes = nodes.concat("{\"id\":\"" + name + "\",\"group\":1," +
                    "\"crimeType\":" + "\"" + prisonerMap.get(name).getCrime() + "\"," +
                    "\"birth\":" + "\"" + birthTime + "\"," +

                    "\"penalty\":" + "\"" + prisonerMap.get(name).getPenalty() + "\"," +
                    "\"penaltySum\":" + "\"" + Float.toString(prisonerMap.get(name).getPenaltySum()) + "\"," +
                    "\"prisonType\":" + "\"" + prisonerMap.get(name).getPrisonType() + "\"," +
                    "\"prisonTime\":" + "\"" + prisonerMap.get(name).getPrisonTime() + "\"," +
                    "\"work\":" + "\"" + prisonerMap.get(name).getWork() + "\"," +
                    "\"address\":" + "\"" + prisonerMap.get(name).getPlace() + "\"," +
                    "\"level\":" + "\"" + prisonerMap.get(name).getLevel() + "\"," +
                    "\"sex\":" + "\"" + prisonerMap.get(name).getSex() + "\"," +
                    "\"nation\":" + "\"" + prisonerMap.get(name).getNation() + "\"," +
                    "\"idCard\":" + "\"" + prisonerMap.get(name).getIdCard() + "\"," +
                    "},\r\n" +
                    "{\"id\":\"" + prisonerMap.get(name).getBeanCrime().getSerial() + "\",\"group\":30" + ",\"area\":\"" + prisonerMap.get(name).getBeanCrime().getArea() + "\"," +
                    "\"criminalProcura\":" + "\"" + prisonerMap.get(name).getBeanCrime().getProcuratorate() + "\"," +
                    "\"criminalCaseTime\":" + "\"" + crimeTime + "\"" + "},\r\n");


            links = links.concat("{\"source\":\"" + name + "\",\"target\":\"" + prisonerMap.get(name).getBeanCrime().getSerial() + "\",\"value\":120,\"relation\":\"" + "案号" + "\"},\r\n");

        }
        for (BeanCase Case : cases) {
            CaseManager manager = new CaseManager();
            if (prisonerMap.containsKey(Case.getPerson1()) && prisonerMap.containsKey(Case.getPerson2()) && !Case.getPerson1().equals(Case.getPerson2())) {
                /**
                 * 入库
                 */
                try {
                    manager.CreateCase(Case);
                } catch (BaseException e) {
                    e.printStackTrace();
                }
                /**
                 * 入库
                 */
                links = links.concat("{\"source\":\"" + Case.getPerson1() + "\",\"target\":\"" + Case.getPerson2() + "\",\"value\":120,\"relation\":\"" + Case.getInfo() + "\"},\r\n");
            }
        }
        String text = "{".concat(nodes).concat("],").concat(links).concat("]}");

        Txt.WriteDictionary(text, savePath + saveName + ".json", false, "UTF-8");
    }


    /**
     * 数据库数据生成提供d3显示的json
     *
     * @param savePath 保存json的路径文件名 //C:\source\javabigwork\out\artifacts\javabigwork_war_exploded\
     */
    public static void sqlParseToJson(String savePath) {
        List<BeanCrime> crimes = null;
        List<BeanCase> cases = null;

        String nodes = "\"nodes\":[ ";
        String links = "\"links\":[ ";


        Session session = HibernateUtil.getSession();
        String hql = "from BeanCrime";
        Query qry = session.createQuery(hql);

        crimes = qry.list();
        for (BeanCrime crime : crimes) {
            String crimeTime = ParseToCsv.formatTime(crime.getDate());
            nodes = nodes.concat(
                    "{\"id\":\"" + crime.getSerial() + "\",\"group\":30" + ",\"area\":\"" + crime.getArea() + "\"," +
                            "\"criminalProcura\":" + "\"" + crime.getProcuratorate() + "\"," +
                            "\"criminalCaseTime\":" + "\"" + crimeTime + "\"" + "},\r\n");
            for (BeanPrisoner prisoner : crime.getPrisonersSet()) {
                String birthTime = ParseToCsv.formatTime(prisoner.getBirth());
                nodes = nodes.concat(
                        "{\"id\":\"" + prisoner.getName() + "\",\"group\":1," +
                                "\"crimeType\":" + "\"" + prisoner.getCrime() + "\"," +
                                "\"birth\":" + "\"" + birthTime + "\"," +
                                "\"penalty\":" + "\"" + prisoner.getPenalty() + "\"," +
                                "\"penaltySum\":" + "\"" + Float.toString(prisoner.getPenaltySum()) + "\"," +
                                "\"prisonType\":" + "\"" + prisoner.getPrisonType() + "\"," +
                                "\"prisonTime\":" + "\"" + prisoner.getPrisonTime() + "\"," +
                                "\"work\":" + "\"" + prisoner.getWork() + "\"," +
                                "\"address\":" + "\"" + prisoner.getPlace() + "\"," +
                                "\"level\":" + "\"" + prisoner.getLevel() + "\"," +
                                "\"sex\":" + "\"" + prisoner.getSex() + "\"," +
                                "\"nation\":" + "\"" + prisoner.getNation() + "\"," +
                                "\"idCard\":" + "\"" + prisoner.getIdCard() + "\"," +
                                "},\r\n");
                links = links.concat("{\"source\":\"" + prisoner.getName() + "\",\"target\":\"" + crime.getSerial() + "\",\"value\":120,\"relation\":\"" + "案号" + "\"},\r\n");
            }
        }
        session.close();

        for (BeanCase Case : cases) {
            if(Case.getInfo().contains("卖"))
                links = links.concat("{\"source\":\"" + Case.getPerson1() + "\",\"target\":\"" + Case.getPerson2() + "\",\"value\":120,\"relation\":\"" + "贩卖" + "\"},\r\n");
            else if(Case.getInfo().contains("买"))
                links = links.concat("{\"source\":\"" + Case.getPerson1() + "\",\"target\":\"" + Case.getPerson2() + "\",\"value\":120,\"relation\":\"" + "购买" + "\"},\r\n");
            else if(Case.getInfo().contains("使"))
                links = links.concat("{\"source\":\"" + Case.getPerson1() + "\",\"target\":\"" + Case.getPerson2() + "\",\"value\":120,\"relation\":\"" + "唆使" + "\"},\r\n");
            else if(Case.getInfo().equals("容留"))
                links = links.concat("{\"source\":\"" + Case.getPerson1() + "\",\"target\":\"" + Case.getPerson2() + "\",\"value\":120,\"relation\":\"" + "容留" + "\"},\r\n");
            else if(Case.getInfo().equals("联系")||Case.getInfo().equals("伙同"))
                links = links.concat("{\"source\":\"" + Case.getPerson1() + "\",\"target\":\"" + Case.getPerson2() + "\",\"value\":120,\"relation\":\"" + "伙同" + "\"},\r\n");
        }
        String text = "{".concat(nodes).concat("],").concat(links).concat("]}");

        Txt.WriteDictionary(text, savePath, false, "UTF-8");
    }
}
