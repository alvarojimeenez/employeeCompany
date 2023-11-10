package com.jacaranda.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jacaranda.utility.DbUtility;

public class DbRepositoryStudio {
	
	public static <T> T find(Class<T> c, int id) throws Exception {
		Session session = null;
		T result = null;
		
		try {
			session = DbUtility.getSessionFactory().openSession();
		}catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		try {
			result = session.find(c, id);
		}catch (Exception e) {
			throw new Exception("Error al obtener la entidad");
		}
		return result;
	}
	
	public static <T> List<T> findAll(Class<T> c) throws Exception{
		Session session = null;
		List<T> result = null;
		
		try {
			session = DbUtility.getSessionFactory().openSession();
		}catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		try {
			result = (List<T>) session.createSelectionQuery("From "+ c.getName()).getResultList();
		}catch (Exception e) {
			throw new Exception("Error al obtener la entidad");
		}
		return result;
	}
	
	public static <T> T add(T emp) throws Exception {
		Transaction transaction = null;
		Session session;
		T result = null;
		try {
			session = DbUtility.getSessionFactory().openSession();
		}catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		transaction = session.beginTransaction();
		
		try {
			session.merge(emp);
			transaction.commit();
		}catch (Exception e) {
			transaction.rollback();
		}
		
		return result;
	}
}
