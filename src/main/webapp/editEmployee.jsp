<%@page import="java.sql.Date"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Employee"%>
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
	
	ArrayList<Company> listCompany = null;
	Employee emp = null;
	try{
		listCompany = (ArrayList<Company>) DbRepository.findAll(Company.class);
		
	}catch(Exception e){
		response.sendRedirect("error.jsp?msg="+e.getMessage());
		return;
	}
	try{
		int idEmpleado = Integer.valueOf(request.getParameter("id"));
		emp = DbRepository.find(Employee.class, idEmpleado);
		int idCompany = Integer.valueOf(request.getParameter("company"));
		Company company = DbRepository.find(Company.class, idCompany);
		if (request.getParameter("submit")!=null){
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String gender = request.getParameter("gender");
			Date dateOfBirth = null;
			try{
				dateOfBirth = Date.valueOf(request.getParameter("dateOfBirth"));
			}catch(Exception e){
				response.sendRedirect("error.jsp?msg=Fecha erronea, formato adecuado: YYYY-MM-dd");
				return;
			}
			emp = new Employee(idEmpleado, firstName, lastName, email, gender, dateOfBirth, company);
			DbRepository.update(emp);
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
        <input id="firstName" name="firstName" type="text" value="<%= emp.getFirstName() %>" class="form-control"> 
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
        <input id="lastName" name="lastName" type="text" class="form-control" value="<%= emp.getLastName() %>"> 
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
        <input id="email" name="email" type="text" class="form-control" value="<%= emp.getEmail() %>"> 
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
        <input id="gender" name="gender" type="text" class="form-control" value="<%= emp.getGender() %>"> 
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
        <input id="dateOfBirth" name="dateOfBirth" type="date" class="form-control" value="<%= emp.getDateOfBirth() %>"> 
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
    	<%
    	for (Company c : listCompany){
    	%>
    	<option value="<%= c.getId() %>"><%= c.getName() %></option>
    	<%
    	}
    	%>
    </select>
    </div>
    </div>
  </div>
    <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="submit" type="submit" class="btn btn-info">Editar empleado</button>
      <a href="list.jsp" class="btn btn-warning">Lista empleados</a>
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