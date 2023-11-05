<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
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
			ArrayList<Employee> result = (ArrayList<Employee>) DbRepository.findAll(Employee.class); // almacenamos en una lista todos los personajes
	%>
	<table class="table">
    <thead>
        <th scope="col">Id</th>
        <th scope="col">Nombre</th>
        <th scope="col">Apellidos</th>
        <th scope="col">Email</th>
        <th scope="col">Género</th>
        <th scope="col">Fecha de nacimiento</th>
        <th scope="col">Nombre compañia</th>
    </thead>
    <tbody>
   	<%
   	   	for (Employee e : result){ // recorremos la lista y añadimos en el formulario todas sus claves primarias junto con un botón de información.
   	%>
   	<tr>
    	<td><%= e.getId() %></td> 
    	<td><%= e.getFirstName() %></td> 
    	<td><%= e.getLastName() %></td> 
    	<td><%= e.getEmail() %></td> 
    	<td><%= e.getGender() %></td>
    	<td><%= e.getDateOfBirth() %></td>
    	<td><%= e.getCompany().getName() %></td>
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
    </tr>
    <% 
   	}
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