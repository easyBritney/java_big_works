package hibernate_test;

import model.BeanCase;
import model.BeanCrime;
import model.BeanPrisoner;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.ArrayList;
import java.util.List;

public class CaseManager {
    public BeanCase CreateCase(BeanCase Case) throws BaseException {
        Session session = HibernateUtil.getSession();
        session.beginTransaction();
        if(Case==null)
            throw new BaseException("null");
        session.save(Case);

        session.getTransaction().commit();
        session.close();
        return Case;
    }

    public static List<BeanCase> loadAllCases() throws BaseException {
        List<BeanCase> list=new ArrayList<>();
        try{
            Session session=HibernateUtil.getSession();
            String hql="from BeanCase";

            Query qry = session.createQuery(hql);

            list=qry.list();
            session.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return list;
    }
}
