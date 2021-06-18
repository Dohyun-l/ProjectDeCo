package com.deco.share;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deco.Action;
import com.deco.ActionForward;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class shareWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		req.setCharacterEncoding("utf-8");
		
		//파일 업로드
		ServletContext ctx = req.getServletContext();
		String realpath = ctx.getRealPath("/share/upload");
		
		int maxSize = 5 * 1024 * 1024;
		
		MultipartRequest multi 
		  = new MultipartRequest(
				  req,
				  realpath,
				  maxSize,
				  "UTF-8",
				  new DefaultFileRenamePolicy()				
				);
		
		System.out.println("파일 업로드 완료");
						
		 String nickname = multi.getParameter("nickname");
	     String title = multi.getParameter("title");
	   	 String category = multi.getParameter("category"); 
	     String filename = multi.getFilesystemName("filename");
	     String anony = multi.getParameter("anony");
		  
	     //다중선택 배열로 받기
	     String[] tag = multi.getParameterValues("tag");    
	     for(int i=0;i<tag.length;i++){
	    	 System.out.println(tag[i]);
	    	 //다중 선택시 디비에( , )로 나눠서 저장할건지... 알려줘 
	     }
	     
	     //디비처리 
	     shareDAO sDAO = new shareDAO();
	    //sDAO.insertShare(sDTO);
	     
		return null;
	}

}
