package reader;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;


import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.ooxml.POIXMLDocument;
import org.apache.poi.ooxml.extractor.POIXMLTextExtractor;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;




public class ReadDocUtil {

	public static String readWord(String fileName){

        File file = new File(fileName);
        if(file.getName().endsWith(".doc")){
            return readWord_2003(file);
        }
//        else if(file.getName().endsWith(".docx")){
//            return readWord_2007(fileName);
//        }
        else{
            System.out.println("���ļ�����word�ĵ���������ѡ��");
            return "";
        }
    }
	public static String readWord_2003(File file){
        String text = "";          
        try{
            InputStream stream = new FileInputStream(file);
            HWPFDocument document = new HWPFDocument(stream);
            WordExtractor word = new WordExtractor(document);
            text = word.getText();
            //ȥ��word�ĵ��еĶ������
            text = text.replaceAll("(\\r\\n){2,}", "\r\n");
            text = text.replaceAll("(\\n){2,}", "\n");
            System.out.println("��ȡWord�ĵ��ɹ���");
            stream.close();
            return text;
        }catch(Exception e){
            e.printStackTrace();           
        }
        return "";
    }
//    public static String readWord_2007(String fileName){
//        String text = "";
//        try{
//            OPCPackage oPCPackage = POIXMLDocument.openPackage(fileName);
//            XWPFDocument xwpf = new XWPFDocument(oPCPackage);
//            POIXMLTextExtractor ex = new XWPFWordExtractor(xwpf);
//            text = ex.getText();
//            //ȥ��word�ĵ��еĶ������
//            text = text.replaceAll("(\\r\\n){2,}", "\r\n");
//            text = text.replaceAll("(\\n){2,}", "\n");
//            System.out.println("��ȡWord�ĵ��ɹ���");
//            return text;
//        }catch(Exception e){
//            e.printStackTrace();
//        }
//        return "";
//    }
}
