package model;

public class BeanDrug {
    private int drugid;
    private String drugType;
    private float drugNum;
    private String drugMagnitude;
    private float drugPrice;
    private String drugPriceMagnitude;
    private int crimeid;
    private BeanCrime beanCrime;

    public int getDrugid() {
        return drugid;
    }

    public void setDrugid(int drugid) {
        this.drugid = drugid;
    }

    public String getDrugType() {
        return drugType;
    }

    public void setDrugType(String drugType) {
        this.drugType = drugType;
    }

    public float getDrugNum() {
        return drugNum;
    }

    public void setDrugNum(float drugNum) {
        this.drugNum = drugNum;
    }

    public String getDrugMagnitude() {
        return drugMagnitude;
    }

    public void setDrugMagnitude(String drugMagnitude) {
        this.drugMagnitude = drugMagnitude;
    }

    public float getDrugPrice() {
        return drugPrice;
    }

    public void setDrugPrice(float drugPrice) {
        this.drugPrice = drugPrice;
    }

    public String getDrugPriceMagnitude() {
        return drugPriceMagnitude;
    }

    public void setDrugPriceMagnitude(String drugPriceMagnitude) {
        this.drugPriceMagnitude = drugPriceMagnitude;
    }

    public int getCrimeid() {
        return crimeid;
    }

    public void setCrimeid(int crimeid) {
        this.crimeid = crimeid;
    }

    public BeanCrime getBeanCrime() {
        return beanCrime;
    }

    public void setBeanCrime(BeanCrime crime) {
        this.beanCrime = crime;
    }
}
