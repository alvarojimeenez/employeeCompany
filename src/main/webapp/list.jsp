<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="com.jacaranda.model.Project"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.model.Company"%>
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
			try{
				String role = (String) session.getAttribute("role");
				ArrayList<Company> result = (ArrayList<Company>) DbRepository.findAll(Company.class); // almacenamos en una lista todos los personajes
				
	%>
	<table class="table">
	<% 
	if (role.equals("admin")){
	%>
	<thead>
    <td>
    	<form action="addEmployee.jsp">
			<button type="submit" class="btn btn-danger">Agregar empleado</button>
	  	</form>
	 </td>
	 <td>
    	<form action="addCompanyProject.jsp">
			<button type="submit" class="btn btn-danger">Agregar proyecto a compañia</button>
	  	</form>
	 </td>
    </thead>
   	<%
	}
   	   	for (Company c : result){ // recorremos la lista y añadimos en el formulario todas sus claves primarias junto con un botón de información.
   	%>
    <tbody>
        <th scope="col">Nombre</th>
        <th scope="col">Numero de empleados</th>
        <th scope="col">Numeros de proyectos</th>
    </tbody>
   	<tr>
    	<td><%= c.getName() %></td> 
    	<td><%= c.getEmpleados().size() %></td>
    	<td> <%= c.getCompanyProject().size() %> 
    	
    </tr>
    <tr>
    	<td> Empleados</td> 
    </tr>
    <%
   	   	for (Employee e : c.getEmpleados()){ // recorremos la lista y añadimos en el formulario todas sus claves primarias junto con un botón de información.
   	%>
    <tr>
    	<td> <%= e.getId() %></td>
    	<td> <%= e.getFirstName() %> </td>
    	<td> <%= e.getLastName() %> </td>
    <%
    if (role.equals("admin")){	
    %>
    	<td>
    		<form action="editEmployee.jsp">
				<input id="id" name="id" type="text" value="<%= e.getId() %>" hidden>
				<button type="submit" class="btn btn-danger">Editar empleado</button>
	  		</form>
	  	</td>
	  	<td>
    		<form action="deleteEmployee.jsp">
				<input id="id" name="id" type="text" value="<%= e.getId() %>" hidden>
				<button type="submit" class="btn btn-warning">Borrar empleado</button>
	  		</form>
	  	</td>
	  <%
    }
    %>
    </tr>
	    <% 
	   	}
	    %>
     <tr>
    	<td> Proyectos</td> 
    </tr>
     <%
   	   	for (CompanyProject p : c.getCompanyProject()){ // recorremos la lista y añadimos en el formulario todas sus claves primarias junto con un botón de información.
   	%>
   	<tr>
    	<td> <%= p.getProject().getId() %></td>
    	<td> <%= p.getProject().getName() %> </td>
    	<td> <%= p.getProject().getButget() %> </td>
    </tr>
    <% 
   	}}
    %>
    
    </tbody>
	<%
	}catch(Exception e){
		out.println(e.getMessage());
	}
	%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</body>
</html>