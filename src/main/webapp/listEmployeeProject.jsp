<%@page import="java.sql.Date"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="com.jacaranda.model.EmployeeProject"%>
<%@page import="com.jacaranda.model.Project"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	Employee employee = null;
	try{
		String role = (String) session.getAttribute("role");
		int idEmployee = (int) session.getAttribute("user");
		employee = DbRepository.find(Employee.class, idEmployee);

	%>
	
	<table class="table">
		<thead>
		<td> Usuario conectado: <b><%= employee.getFirstName() %></b></td>
		<td scope="col">
			<form action="asignProject.jsp">
				<button type="submit" class="btn btn-success">Asignar proyecto</button>
	  		</form>
		</td>
		<td scope="col">
			<form action="asignMultiProject.jsp">
				<button type="submit" class="btn btn-success">Asignar múltiples proyectos</button>
	  		</form>
		</td>
		<%
		if (role.equals("admin")){
		%>
		<td scope="col">
			<form action="addCompanyProject.jsp">
				<button type="submit" class="btn btn-success">Agregar</button>
	  		</form>
		</td>
		<%
		}
		%>
		</thead>
		<tbody>
        <th scope="col">Id project</th>
        <th scope="col">Name project</th>
        <th scope="col">Butget</th>
   	<%
   	   	for (CompanyProject c : employee.getCompany().getCompanyProject()){
   	 		if (c.getEnd().after(Date.valueOf(LocalDate.now()))){
   	 			
   	 		
   	%>
   	<tr>
    	<td><%= c.getProject().getId() %></td> 
    	<td><%= c.getProject().getName() %></td> 
    	<td><%= c.getProject().getButget() %></td>
    </tr>
    <% 
   	 }}
    %>
    </tbody>
	
	</table>
	
	<% 
	}catch(Exception e){
		
	}
	%>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</body>
</html>