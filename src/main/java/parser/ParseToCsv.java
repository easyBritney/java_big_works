package parser;

import javafx.util.Pair;
import match.MatchCrime;
import model.BeanCase;
import model.BeanCrime;
import tools.Csv;

import java.util.ArrayList;

public class ParseToCsv {
    //writer(String filepath, Pair<String[], ArrayList<String[]>> data, boolean hasHeader, String charSet)
    BeanCrime crime = new MatchCrime().Match("E:\\ѧϰ\\java��Ŀ\\��ɽ\\��2016����0902�̳�00262��.doc");
    String [] titles={"����","��Ժ����","һ������","������С��Ա��������","��һ��������","����","�̷�����","����","�Ʋ�������","�Ʋ��̽��","��Ʒ�����������λ","��Ʒ����"};


   // writer("E:\\ѧϰ\\java��Ŀ\\test.csv",new Pair<String[], ArrayList<String[]>>(),true,"UTF-8");
}
