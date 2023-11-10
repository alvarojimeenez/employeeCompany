package com.jacaranda.model;

import java.sql.Date;
import java.util.Objects;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "employeeProject")
public class EmployeeProject {
	
	@Id
	@ManyToOne
	@JoinColumn(name="idEmployee")
	private Employee employee;
	
	@Id
	@ManyToOne
	@JoinColumn(name="idProject")
	private Project project;
	
	private double hora;

	public EmployeeProject() {
		super();
		
	}
	public EmployeeProject(Employee employee, Project project, double hora) {
		super();
		this.employee = employee;
		this.project = project;
		this.hora = hora;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public double getHora() {
		return hora;
	}

	public void setHora(double hora) {
		this.hora = hora;
	}

	@Override
	public int hashCode() {
		return Objects.hash(employee, project);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		EmployeeProject other = (EmployeeProject) obj;
		return Objects.equals(employee, other.employee) && Objects.equals(project, other.project);
	}
	
}
