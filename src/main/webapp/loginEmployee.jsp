<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="style.css" rel="stylesheet">
</head>
<body>
	<%
	Employee employee = null;
	try {
		int id = Integer.valueOf(request.getParameter("id"));
		String password = request.getParameter("password");
		employee = DbRepository.find(Employee.class, id);
		if (request.getParameter("submit")!=null && employee!=null && employee.getPassword().equals(password)){
			session.setAttribute("user", employee.getId());
			session.setAttribute("role", employee.getRole());
			response.sendRedirect("listEmployeeProject.jsp");	
			return;
		}else if(employee!=null && !employee.getPassword().equals(password)) {
			response.sendRedirect("error.jsp?msg=La contrasenia no es correcta.");
		}else {
			response.sendRedirect("error.jsp?msg=El usuario no esta registrado.");
		}
			
	}catch(Exception e){
		
	}
	
	
	%>

<section class="login-block">
    	<div class="container">
		<div class="row ">
		<div class="col login-sec">
		   	<h2 class="text-center">Login Now</h2>
		    <form class="login-form">
  				<div class="form-group">
  					<label for="exampleInputEmail1" class="text-uppercase">Username</label>
  					<input type="text" name="id" class="form-control">
  
			    </div>
				<div class="form-group">
  					<label for="exampleInputPassword1" class="text-uppercase">Password</label>
  					<input type="password" name="password" class="form-control">
		  		</div>

  		   		<div class="form-check">
  					<button type="submit" name="submit" class="btn btn-login float-right">Submit</button>
	  	   		</div>
    	   </form>
  
  		</div>
    	</div>
    	</div>
</body>
</html>