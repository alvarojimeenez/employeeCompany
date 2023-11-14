<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="java.sql.Date"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Project"%>
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
	String role = (String) session.getAttribute("role");
	
	ArrayList<Company> listCompany = null;
	ArrayList<Project> listProject = null;
	ArrayList<CompanyProject> listCompanyProject = null;
	try{
		listCompany = (ArrayList<Company>) DbRepository.findAll(Company.class);
		listProject = (ArrayList<Project>) DbRepository.findAll(Project.class);
		listCompanyProject = (ArrayList<CompanyProject>) DbRepository.findAll(CompanyProject.class);
		
		int idCompany = Integer.valueOf(request.getParameter("idCompany"));
		Company company = DbRepository.find(Company.class, idCompany);
		
		int idProject = Integer.valueOf(request.getParameter("idProject"));
		Project project = DbRepository.find(Project.class, idProject);
		
		Date begin = Date.valueOf(request.getParameter("begin"));
		Date end = Date.valueOf(request.getParameter("end"));
		
		CompanyProject cp = new CompanyProject(company, project, begin, end);
		if (request.getParameter("submit")!=null){
			for (CompanyProject comPro : listCompanyProject){
				if (comPro.hashCode()== cp.hashCode()){
					response.sendRedirect("error.jsp?msg=Ya existe");
				}else {
					DbRepository.add(cp);	
				}
			}
		}
	}catch(Exception e){
		
	}
	
	if (role.equals("admin")){
	%>
<form>
    <div class="form-group row">
    <label for="" class="col-4 col-form-label">Id company</label> 
    <div class="col-8">
      <div class="input-group">
        <select class="form-control" name="idCompany">
    	<option value="">Selecciona una compañía </option>
    	<%
    	for (Company c : listCompany){
    	%>
    	<option value="<%= c.getId() %>"><%= c.getName() %></option>
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
    <div class="form-group row">
    <label for="" class="col-4 col-form-label">Id project</label> 
    <div class="col-8">
      <div class="input-group">
        <select class="form-control" name="idProject">
    	<option value="">Selecciona una compañía </option>
    	<%
    	for (Project p : listProject){
    	%>
    	<option value="<%= p.getId() %>"><%= p.getName() %></option>
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
  <div class="form-group row">
    <label for="" class="col-4 col-form-label">Begin</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="begin" name="begin" type="date" class="form-control" required="required"> 
        <div class="input-group-append">
          <div class="input-group-text">
            <i class="fa fa-camera-retro"></i>
          </div>
        </div>
      </div>
    </div>
  </div> 
  <div class="form-group row">
    <label for="" class="col-4 col-form-label">End</label> 
    <div class="col-8">
      <div class="input-group">
        <input id="end" name="end" type="date" class="form-control" required="required"> 
        <div class="input-group-append">
          <div class="input-group-text">
            <i class="fa fa-camera-retro"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="form-group row">
    <div class="offset-4 col-8">
      <button name="submit" type="submit" class="btn btn-danger">Agregar proyecto</button>
      <button type="submit" name="submit" class="btn btn"><a href="listEmployeeProject.jsp">Volver a la lista</a></button>
    </div>
  </div>
		
	</form>
	<%
	}else {
		response.sendRedirect("error.jsp?msg=Necesitas permiso de administrador.");
	}
	%>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</body>
</html>