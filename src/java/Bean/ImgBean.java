/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bean;

/**
 *
 * @author Felipe
 */
public class ImgBean {
    private String id;
    private String userid;
    private String fileName;
    private String category;
    private String date;
    
    
    
    public String getFileName(){
        return fileName;
    }
    public String getPrimaryKey(){
        return id;
    }
    public String getUserId(){
        return userid;
    }    
    public String getDate(){
        return date;
    }
    public String getCategory(){
        return category;
    }
 
    public void setFileName(String newName){
        fileName = newName;
    }
    public void setPrimaryKey(String newId){
        id = newId;
    }
    public void setUserId(String userId){
        userid = userId;
    }
    public void setDate(String newDate){
        date = newDate;
    }
    public void setCategory(String newCategory){
        category = newCategory;
    }

            
}
