<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Date"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Employee"%>
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
	String role = (String) session.getAttribute("role");
	
	Employee emp = null;
	try{
		int idEmpleado = Integer.valueOf(request.getParameter("id"));
		emp = DbRepository.find(Employee.class, idEmpleado);
		int idCompany = Integer.valueOf(request.getParameter("company"));
		Company company = DbRepository.find(Company.class, idCompany);
		if (request.getParameter("submit")!=null){
			DbRepository.delete(emp);
		}
		
	}catch(Exception e){
		
	}
	
	if (role.equals("admin")){
	%>
	<form>
	<input id="id" name="id" type="text" value="<%= emp.getId() %>" class="form-control" hidden> 
    <div class="form-group row">
    <label for="" class="col-4 col-form-label">First name</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="firstName" name="firstName" type="text" value="<%= emp.getFirstName() %>" class="form-control" readonly="readonly"> 
        <div class="input-group-append">
          <div class="input-group-text">
            <i class="fa fa-camera-retro"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
    <div class="form-group row">
    <label for="" class="col-4 col-form-label">Last name</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="lastName" name="lastName" type="text" class="form-control" value="<%= emp.getLastName() %>" readonly="readonly"> 
        <div class="input-group-append">
          <div class="input-group-text">
            <i class="fa fa-camera-retro"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="" class="col-4 col-form-label">Email</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="email" name="email" type="text" class="form-control" value="<%= emp.getEmail() %>" readonly="readonly"> 
        <div class="input-group-append">
          <div class="input-group-text">
            <i class="fa fa-camera-retro"></i>
          </div>
        </div>
      </div>
    </div>
  </div> 
  <div class="form-group row">
    <label for="" class="col-4 col-form-label">Gender</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="gender" name="gender" type="text" class="form-control" value="<%= emp.getGender() %>" readonly="readonly"> 
        <div class="input-group-append">
          <div class="input-group-text">
            <i class="fa fa-camera-retro"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="" class="col-4 col-form-label">Date of birth</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="dateOfBirth" name="dateOfBirth" type="date" class="form-control" value="<%= emp.getDateOfBirth() %>" readonly="readonly"> 
        <div class="input-group-append">
          <div class="input-group-text">
            <i class="fa fa-camera-retro"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="form-group row"> 
    <label for="character" class="col-4 col-form-label">Company</label>
    <div class="col-8">
      <div class="input-group"> 
    <select class="form-control" name="company">
    	<option value="<%= emp.getCompany().getId() %>"><%= emp.getCompany().getName() %></option>
    </select>
    </div>
    </div>
  </div>
    <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="submit" type="submit" class="btn btn-danger">Borrar empleado</button>
      <a href="list.jsp" class="btn btn-warning">Volver</a>
    </div>
  </div> 
  <%
	}else {
		response.sendRedirect("error.jsp?msg=Necesitas permiso de administrador.");
	}
  %> 
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</body>
</html>