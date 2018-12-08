package tools;

import java.io.*;

public class Txt {
    public static void WriteDictionary(String text,String filePath,Boolean append,String charSet)
    {
        FileWriter fw = null;
        try {
            File f=new File(filePath);
            FileOutputStream writerStream = new FileOutputStream(f,append);

            BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(writerStream, charSet));
            writer.write(text);
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public static String ReadeDictionary(String filePath)
    {
        StringBuilder result = new StringBuilder();
        try{
            BufferedReader br = new BufferedReader(new FileReader(new File(filePath))); //构造一个BufferedReader类来读取文件
            String s = null;
            while((s = br.readLine())!=null){
                result.append(System.lineSeparator()+s);
            }
            br.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return result.toString();
    }

}

