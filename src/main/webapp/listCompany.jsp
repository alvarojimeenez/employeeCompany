<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.model.Company"%>
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
			ArrayList<Company> result = (ArrayList<Company>) DbRepository.findAll(Company.class); // almacenamos en una lista todos los personajes
	%>
	<table class="table">
    <thead>
        <th scope="col">Id</th>
        <th scope="col">Nombre</th>
        <th scope="col">Dirección</th>
        <th scope="col">Ciudad</th>
        <th scope="col">Empleados</th>
    </thead>
    <tbody>
   	<%
   	   	for (Company e : result){ // recorremos la lista y añadimos en el formulario todas sus claves primarias junto con un botón de información.
   	%>
   	<tr>
    	<td><%= e.getId() %></td> 
    	<td><%= e.getName() %></td> 
    	<td><%= e.getAddress() %></td> 
    	<td><%= e.getCity() %></td> 
    	<td><%= e.getEmpleados().size() %></td> 
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
</body>
</html>