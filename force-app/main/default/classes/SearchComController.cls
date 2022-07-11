public with sharing class SearchComController {

    @AuraEnabled
    public static void deleteStudent(String accId){
        Database.delete(accId);
    }
    
    @AuraEnabled
    public  static List<HocSinh__c> queryStudent(String lastName,Boolean isSort,String classId,Date startBirthday, Date endBirthday ,Integer currentPage){
        try{
            String queryStudent='SELECT Id, MaHocSinh__c, HoHocSinh__c, TenHocSinh__c, NgaySinh__c, GioiTinh__c, Diem1__c, Diem2__c,Diem3__c, DiemTB__c,TinhTrang__c FROM  HocSinh__c';
            // rap điều kiện
            queryStudent= createStringQuery(queryStudent,lastName, classId, startBirthday, endBirthday );
            System.debug('queryStudent'+queryStudent);
            if(isSort){
                queryStudent += ' ORDER BY TenHocSinh__c  ';
            }else{
                queryStudent += ' ORDER BY TenHocSinh__c  DESC ';
            }
            queryStudent +=' LIMIT 5';
            Integer offsetNum= (5 * (currentPage - 1));
            queryStudent += 'OFFSET '+offsetNum;
            List<HocSinh__c> hs=  Database.query(queryStudent);
            return hs;
        }catch(Exception ex){
            System.debug('error');
            return null;
        }
   }
   
   @AuraEnabled
   public static String createStringQuery(String queryString, String lastName,String classId,Date startBirthday, Date endBirthday){ 
     
    String allClass='SELECT_ALL';
    try {
        if(String.isNotBlank(lastName.trim())) {
            queryString += ' AND TenHocSinh__c like \'%' + String.escapeSingleQuotes(lastName.trim())+'%\'';
       }
       
        if(String.isNotBlank(classId) && !classId.equals(allClass)){
            queryString += ' AND Lop__c =\''+classId+'\'';  
       }

        if(startBirthday != null && endBirthday != null){
           //Cắt lấy ngày
              String dt1= String.valueOf(startBirthday).substring(0,10);
              String dt2= String.valueOf(endBirthday).substring(0,10);
           queryString += 'AND NgaySinh__c > '+dt1+' AND NgaySinh__c < '+ dt2;
        }

       // thay đổi chuỗi
        queryString = queryString.replaceFirst('AND', 'WHERE');

        return queryString;           
    } catch (Exception ex) {
       return queryString;
    }
}

@AuraEnabled
public static Integer countStudent(String lastName,Boolean isSort,String classId,Date startBirthday, Date endBirthday){
    try{

        String queryCount='SELECT COUNT() FROM HocSinh__c';
        queryCount= createStringQuery(queryCount,lastName, classId, startBirthday, endBirthday );
        Integer count = Database.countQuery(queryCount);
        // totalPage = (Integer) Math.ceil((Decimal) count / LIMIT_ROW);
        return count;
    }catch( Exception ex){
        // this.getExceptionMessage(ex);
        return 0;
    }
 }

@AuraEnabled
    public static List<Lop__c> methodGetDataClass(){
        try {
            List<Lop__c> listData = [SELECT Id, TenLop__c FROM Lop__c ORDER BY TenLop__c];
            return listData;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    class Search{
        public Integer countStudent {get; set;}
        public List<HocSinh__c> listStudent {get; set;}
          public Search() {
            countStudent = 10;
            listStudent = new List<HocSinh__c>();
          }
      }
}