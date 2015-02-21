/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

/**
 *
 * @author Felipe
 */
public class StorageManager {
 //request.getContextPath()
    private static String storagePath = "e:\\temp\\";
    
    public void setStoragePath(String path){
        this.storagePath = path;
    }
    public String getStoragePath(){
        return this.storagePath;
    }
}
