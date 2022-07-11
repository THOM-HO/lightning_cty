public class HocSinhHandler {
    public static Boolean flag = true;
    public static Boolean isAgeValid(Date birthday,Integer beginAge, Integer endDay){
        Integer days = birthday.daysBetween(Date.Today());
        Integer age = Integer.valueOf(days/365);
        if(age >= beginAge && age <= endDay) return true;
        return false;
    } 

   public static String classification(HocSinh__c student){
    Double point= student.DiemTB__c;
        if(point >=0 && point <5){
            return 'Yếu';
        }else if(point >=5 && point < 6.5){
            return 'Trung Bình';
        }else if(point >=6.5 && point < 8){
            return 'Khá';
        }else if(point >=8 && point <= 10){
            return 'Giỏi';
        }
       return 'null'; 
   }
}