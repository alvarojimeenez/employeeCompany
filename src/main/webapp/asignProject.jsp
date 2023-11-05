<%@page import="java.time.LocalTime"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.jacaranda.model.CompanyProject"%>
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
	Employee employee = null;
	double hora=0;
	try{
		int idEmployee = (int) session.getAttribute("user");
		employee = DbRepository.find(Employee.class, idEmployee);
		
		if (request.getParameter("begin")!=null && session.getAttribute("time")==null){
			session.setAttribute("time", LocalTime.now());
		}else if (request.getParameter("end")!=null && session.getAttribute("time")!=null){
			hora = ChronoUnit.SECONDS.between((LocalTime)session.getAttribute("time"), LocalTime.now());
			hora = hora/60;
			session.setAttribute("time", null);
		}
		
	
	%>
	<br>
	<form action="">
  <div class="form-group row">
    <label for="character" class="col-4 col-form-label">Id employee</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="nameCharacter" name="nameCharacter" type="text" class="form-control" value="<%= employee.getId() %>" readonly="readonly"> 
        <div class="input-group-append">
          <div class="input-group-text">
            <i class="fa fa-camera-retro"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
    <div class="form-group row">
    <label for="character" class="col-4 col-form-label">Nombre</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="nationality" name="nationality" type="text" class="form-control" value="<%= employee.getFirstName() %>" readonly="readonly"> 
        <div class="input-group-append">
          <div class="input-group-text">
            <i class="fa fa-camera-retro"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
    <div class="form-group row">
    <label for="character" class="col-4 col-form-label">Projects</label> 
    <div class="col-8">
      <div class="input-group">
        <select name="project">
        	<% 
        	for (CompanyProject cp : employee.getCompany().getCompanyProject()){
        	%>	
        	<option value="<%= cp.getProject() %>"> <%= cp.getProject().getName() %></option>
        	<%
        	}
        	%>
        
        </select>
        <div class="input-group-append">
          <div class="input-group-text">
            <i class="fa fa-camera-retro"></i>
          </div>
        </div>
      </div>
    </div>
  </div> 
	<% 
	if (session.getAttribute("time")==null){
	%>
	 <div class="form-group row">
    <label for="character" class="col-4 col-form-label">Time</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="time" name="time" type="text" class="form-control" value="<%= hora %>" readonly="readonly"> 
        <div class="input-group-append">
          <div class="input-group-text">
            <i class="fa fa-camera-retro"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
		<button type="submit" name="begin" class="btn btn-danger">Comenzar proyecto</button>
    </div>
	<%
	}else{	
	%>
	<div class="col">
		<button type="submit" name="end" class="btn btn-danger">Terminar proyecto</button>
    </div>
	<%	
	}
	}catch(Exception e){
		
	}
	%>
</div>
</form>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</body>
</html>