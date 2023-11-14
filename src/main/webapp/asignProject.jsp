<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.model.Project"%>
<%@page import="com.jacaranda.model.EmployeeProject"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.temporal.ChronoUnit"%>
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
	Project project = null;
	EmployeeProject employeeProject = null;
	ArrayList<EmployeeProject> listEmployeeProject = null;
	LocalTime timeStart = null;
	double hora=0;
	boolean boton = false;
	try{
		int idEmployee = (int) session.getAttribute("user");
		employee = DbRepository.find(Employee.class, idEmployee);
		
		if (request.getParameter("begin")!=null){
			timeStart = LocalTime.now();
			session.setAttribute("time", timeStart);
			project = DbRepository.findProject(Project.class, request.getParameter("project"));
			session.setAttribute("idProject", project);
			boton = true;
			session.setAttribute("boton", boton);
			
		}else if (request.getParameter("end")!=null){
			LocalTime timeEnd = LocalTime.now();
			timeStart = (LocalTime) session.getAttribute("time");
			
			hora = ChronoUnit.SECONDS.between(timeStart, timeEnd);
			
			employeeProject = new EmployeeProject(employee, (Project) session.getAttribute("idProject"), hora);
			
			boolean exist =DbRepository.find(EmployeeProject.class, employeeProject)!=null;
			if (exist){
				Double horaActualizada = hora+employeeProject.getHora();
				employeeProject.setHora(horaActualizada);
				DbRepository.update(employeeProject);
			}else {
				DbRepository.add(employeeProject);
			}
			
			session.setAttribute("time", null);
		}
	}catch(Exception e){
		
	}
	
	%>
	<br>
	<form>
  <div class="form-group row">
    <label for="user" class="col-4 col-form-label">Id employee</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="id" name="id" type="text" class="form-control" value="<%= employee.getId() %>" readonly="readonly"> 
        <div class="input-group-append">
          <div class="input-group-text">
            <i class="fa fa-camera-retro"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
    <div class="form-group row">
    <label for="user" class="col-4 col-form-label">Nombre</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="nombre" name="nombre" type="text" class="form-control" value="<%= employee.getFirstName() %>" readonly="readonly"> 
        <div class="input-group-append">
          <div class="input-group-text">
            <i class="fa fa-camera-retro"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
    <div class="form-group row">
    <label for="user" class="col-4 col-form-label">Projects</label> 
    <div class="col-8">
      <div class="input-group">
        <select name="project">
        	<% 
        	if (!boton){
        		for (CompanyProject cp : employee.getCompany().getCompanyProject()){
        			if (cp.getEnd().after(Date.valueOf(LocalDate.now()))){
		        	%>	
		        	<option value="<%= cp.getProject().getId() %>"> <%= cp.getProject().getName() %></option>
		        	<%
	        		}
        		}
        	}else{
        		project = (Project) session.getAttribute("idProject");
        			%>
        			<option value="<%= project.getId() %>"> <%= project.getName() %></option>
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
    <label for="user" class="col-4 col-form-label">Time</label> 
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
		<button type="submit" name="begin" class="btn btn-warning">Comenzar proyecto</button>
    </div>
	<%
	}else{	
	%>
	<div class="col">
		<button type="submit" name="end" class="btn btn-warning">Terminar proyecto</button>
	<%	
	}
	%>
	<button type="submit" name="submit" class="btn btn"><a href="listEmployeeProject.jsp">Volver a la lista</a></button>
    </div>
</form>
	<%
	
	%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</body>
</html>