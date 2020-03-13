<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" import="com.google.gson.*, com.tis.retulix.domain.*"%>
    <%
   	 Trailer_ViewVO tmp  = (Trailer_ViewVO)request.getAttribute("mvo");
    
    	Gson gson = new Gson();
    	String result = gson.toJson(tmp);
    	System.out.println(result);
    	
    %>
<%=result%>