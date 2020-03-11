<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	int result = (int)request.getAttribute("result");
    	System.out.println("나오냐  결과 : "+result);
    
    
    %>
  {
  	"result":<%=result%>
  }