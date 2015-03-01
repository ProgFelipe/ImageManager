package Servlet;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Felipe
 */

import Bean.ImgBean;
import Bean.UserBean;
import DAO.ImageDAO;
import DAO.UserDAO;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;


import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/*
*Reference :
*http://stackoverflow.com/questions/2422468/how-to-upload-files-to-server-using-jsp-servlet
*/
@WebServlet("/UploadServlet")
//@MultipartConfig(maxFileSize = 16177215)// upload file's size up to 16MB
@MultipartConfig(location="",fileSizeThreshold=1024*1024*2,	// 2MB 
				 maxFileSize=1024*1024*10,		// 10MB
				 maxRequestSize=1024*1024*50)	// 50MB
public class UploadServlet extends HttpServlet {
    // database connection settings
        static Connection currentCon = null;
        static ResultSet rs = null;
        static String userid = "";
	/**
	 * Name of the directory where uploaded files will be saved, relative to
	 * the web application directory.
	 */
	static String fileName = null;
	/**
	 * handles file upload
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {              
                String description = request.getParameter("category"); // Retrieves <input type="text" name="description">
                Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">
                String fileName = extractFileName(filePart);
                
                InputStream fileContent = filePart.getInputStream();
            
                String category = request.getParameter("category");
                //Current session User
                HttpSession s=request.getSession();
                UserBean currentUser = (UserBean) (s.getAttribute("currentSessionUser"));
                String user = currentUser.getUsername();
                                //Get user id
		UserDAO daoUser = new UserDAO();
                String userId = daoUser.getUserId(user);
		// constructs path of the directory to save uploaded file
		//String savePath = appPath + File.separator + SAVE_DIR;
                //Before String savePath = "e:\\temp\\"+userId;
		//String savePath = appPath+"/imgs/"+userId;
                  // gets absolute path of the web application
                //String appPath = System.getProperty("user.dir");
                
                StorageManager stm = new StorageManager();
                String savePath = stm.getStoragePath()+userId;
		// creates the save directory if it does not exists
		File fileSaveDir = new File(savePath);
                
		if (!fileSaveDir.exists()) {
			fileSaveDir.mkdir();
		}
                savePath +=  "/"+category;
                
                fileSaveDir = new File(savePath);
                if (!fileSaveDir.exists()) {
			fileSaveDir.mkdir();
		}
                
                try{
                    InputStream is = filePart.getInputStream(); 
                    int i = is.available(); 
                    byte[] b  = new byte[i]; 
                    is.read(b); 
                    fileName = extractFileName(filePart); 
                    FileOutputStream os = new FileOutputStream(savePath+"/"+ fileName); 
                    os.write(b); 
                    is.close(); 
                
                
                //filePart.write("E:\\temp\\1\\abstract\\"+ fileName);
		/*
		for (Part part : request.getParts()) {
                        fileName = extractFileName(part);
                            part.write(savePath + File.separator + fileName);
		}*/
                //Set imgage metadata on DAO
                ImgBean img = new ImgBean();
                img.setUserId(userId);
                img.setCategory(category);
                img.setFileName(fileName);
                
                ImageDAO.uploadDataImg(img);
  
                }catch(Exception e){
                request.setAttribute("message", "Error "+e+"!</br>");
            getServletContext().getRequestDispatcher("/uploader.jsp").forward(
            		request, response);
                
                }
            request.setAttribute("message", "Upload has been done successfully!</br>"
                    + "<a href='servlet1?filename="+fileName+"&&category="+category+"'>See your latest upload image</a></br>"
                    + "<a href='index.jsp'>Back To HOME</a>");
            getServletContext().getRequestDispatcher("/uploader.jsp").forward(
            		request, response);
	}

	/**
	 * Extracts file name from HTTP header content-disposition
	 */
	private String extractFileName(Part part) {
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				return s.substring(s.indexOf("=") + 2, s.length()-1);
			}
		}
		return "";
	}
        
}