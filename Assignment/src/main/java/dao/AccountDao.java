/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import model.Account;

/**
 *
 * @author DELL
 */

public class AccountDao {

    public AccountDao() {

    }

    static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("Assignment");

    public void create(Account acc) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(acc);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // truy xuat du lieu
    public Account findByUserName(String username) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT a FROM Account a WHERE a.username = :u", Account.class)
                    .setParameter("u", username).getResultStream().findFirst().orElse(null);

        } finally {
            em.close();
        }
    }

    public Account findByEmail(String email) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT a FROM Account a WHERE a.email = :e", Account.class)
                    .setParameter("e", email).getResultStream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }

    public void updatePasswordByEmail(String email, String newPasswordHash) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.createQuery("UPDATE Account a SET a.password = :p WHERE a.email = :e")
                    .setParameter("p", newPasswordHash)
                    .setParameter("e", email)
                    .executeUpdate();
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
