public class HocSinhTriggerHandler {
    
    private static String STR_ERROR_EMPTY = 'Chưa nhập {0}';
    private static String STR_ISVALIDATE = '{0} chưa hợp lệ!';
    private static final Integer beginDay = 6, endDay = 18 ;
    private static String STR_EMPTY_MATH = 'Hãy vào điểm cho môn {0}';
    
    //Before
    public static void onBeforeInsert(List<HocSinh__c> list_trigger_new){ 
       for(HocSinh__c hs : list_trigger_new ){
            if(hs.NgaySinh__c == null){
                hs.NgaySinh__c.addError(String.format(STR_ERROR_EMPTY, new List<String> {'ngày sinh'}));
            }
            
            if(!HocSinhHandler.isAgeValid(hs.NgaySinh__c, beginDay, endDay ))
                hs.NgaySinh__c.addError(String.format(STR_ISVALIDATE, new List<String> {'Tuổi'}));
          
            if(hs.Diem1__c == null){
                hs.Diem1__c.addError(String.format(STR_EMPTY_MATH, new List<String> {'Hóa'}));
            }
            if(hs.Diem2__c == null){
                hs.Diem2__c.addError(String.format(STR_EMPTY_MATH, new List<String> {'Lý'}));
            }
            if(hs.Diem3__c == null){
                hs.Diem3__c.addError(String.format(STR_EMPTY_MATH, new List<String> {'Toán'}));
            }
        }  
    }
    
    // After
    public static void onAfterInsert(List<HocSinh__c> list_trigger_new){
       updateClass(list_trigger_new); 
       List<HocSinh__c> listStudent= new List<HocSinh__c>(); 
       for(HocSinh__c item: list_trigger_new){
          HocSinh__c student = new HocSinh__c();
          student.Id= item.Id;
          student.XepLoai__c = HocSinhHandler.classification(item);
          listStudent.add(student);
       } 
       update listStudent;
    }

     public static void onAfterUpdate(List<HocSinh__c> list_trigger_new, List<HocSinh__c> list_trigger_old){
       List<HocSinh__c> listTriggerNew= new List<HocSinh__c>();
       List<HocSinh__c> listTriggerOld= new List<HocSinh__c>();
       listTriggerNew = list_trigger_new;
       listTriggerOld = list_trigger_old;
       List<HocSinh__c> listTrigger= new List<HocSinh__c>();
       listTrigger.addAll(listTriggerNew);
       listTrigger.addAll(listTriggerOld);
       updateClass(listTrigger); 

      if(HocSinhHandler.flag){
        HocSinhHandler.flag = false;
        List<HocSinh__c> listStudent= new List<HocSinh__c>(); 
        for(HocSinh__c item: list_trigger_new){
            HocSinh__c student = new HocSinh__c();
            student.Id= item.Id;
            student.XepLoai__c = HocSinhHandler.classification(item);
            listStudent.add(student);
        } 
        if(!listStudent.isEmpty()){
                update listStudent;
            HocSinhHandler.flag = true;
        }
    }
}
    
    public static void onAfterDelete(List<HocSinh__c> list_trigger_old){
     updateClass(list_trigger_old);
    }
    
    public static void updateClass(List<HocSinh__c> listStudent){
        Map< ID, Integer> maphs = new Map<ID, Integer>();     
          for(HocSinh__c hs : listStudent){
              if(!maphs.containsKey(hs.Lop__c)){
                  maphs.put(hs.Lop__c,1);
              }else{
                  maphs.put(hs.Lop__c,maphs.get(hs.Lop__c)+1 );
              }
          }
        List<Lop__c> lops= new List<Lop__c> ();
         for (String key : maphs.keySet()) {
    		 Lop__c c = Database.query('SELECT Id,SiSo__c, HocSinhRot__c, HocSinhDau__c FROM Lop__c WHERE Id = \''+key+ '\'');
             c.SiSo__c = Database.countQuery('SELECT COUNT() FROM HocSinh__c WHERE Lop__c = \''+key+'\'' );
             c.HocSinhRot__c = Database.countQuery('SELECT COUNT() FROM HocSinh__c WHERE Lop__c = \''+key+'\' AND DiemTB__c < 5 ' );
             c.HocSinhDau__c = Database.countQuery('SELECT COUNT() FROM HocSinh__c WHERE Lop__c = \''+key+'\' AND DiemTB__c >= 5 ' );
             lops.add(c);
		}
         update lops;
    }
      
}