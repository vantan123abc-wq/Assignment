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

    public long countAllUsers() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT COUNT(a) FROM Account a", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }

    public long countActiveUsers() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT COUNT(a) FROM Account a WHERE a.status = true", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }

    public long countNewUsers(int days) {
        EntityManager em = emf.createEntityManager();
        try {
            java.util.Calendar cal = java.util.Calendar.getInstance();
            cal.add(java.util.Calendar.DAY_OF_YEAR, -days);
            java.util.Date thresholdDate = cal.getTime();
            return em.createQuery("SELECT COUNT(a) FROM Account a WHERE a.createdAt >= :date", Long.class)
                    .setParameter("date", thresholdDate)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    public long countUsers(String roleKeyword, String searchKeyword) {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT COUNT(a) FROM Account a WHERE 1=1";
            if (roleKeyword != null && !roleKeyword.isEmpty() && !roleKeyword.equalsIgnoreCase("All")
                    && !roleKeyword.equalsIgnoreCase("Tất cả")) {
                jpql += " AND a.role = :role";
            }
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                jpql += " AND (a.username LIKE :kw OR a.email LIKE :kw OR a.fullName LIKE :kw)";
            }
            var query = em.createQuery(jpql, Long.class);
            if (roleKeyword != null && !roleKeyword.isEmpty() && !roleKeyword.equalsIgnoreCase("All")
                    && !roleKeyword.equalsIgnoreCase("Tất cả")) {
                query.setParameter("role", roleKeyword);
            }
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                query.setParameter("kw", "%" + searchKeyword.trim() + "%");
            }
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public java.util.List<Account> findUsers(String roleKeyword, String searchKeyword, int page, int size) {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT a FROM Account a WHERE 1=1";
            if (roleKeyword != null && !roleKeyword.isEmpty() && !roleKeyword.equalsIgnoreCase("All")
                    && !roleKeyword.equalsIgnoreCase("Tất cả")) {
                jpql += " AND a.role = :role";
            }
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                jpql += " AND (a.username LIKE :kw OR a.email LIKE :kw OR a.fullName LIKE :kw)";
            }
            jpql += " ORDER BY a.id DESC"; // Default order

            var query = em.createQuery(jpql, Account.class);
            if (roleKeyword != null && !roleKeyword.isEmpty() && !roleKeyword.equalsIgnoreCase("All")
                    && !roleKeyword.equalsIgnoreCase("Tất cả")) {
                query.setParameter("role", roleKeyword);
            }
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                query.setParameter("kw", "%" + searchKeyword.trim() + "%");
            }

            int offset = (page - 1) * size;
            query.setFirstResult(offset);
            query.setMaxResults(size);

            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void updateAccount(int id, String fullName, String email, String phone, String role) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Account a = em.find(Account.class, id);
            if (a != null) {
                if (fullName != null && !fullName.trim().isEmpty())
                    a.setFullName(fullName.trim());
                if (email != null && !email.trim().isEmpty())
                    a.setEmail(email.trim());
                a.setPhone(phone != null ? phone.trim() : null);
                if (role != null && !role.trim().isEmpty())
                    a.setRole(role.trim());
                em.merge(a);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public Account findById(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Account.class, id);
        } finally {
            em.close();
        }
    }

    public void changeRole(int id, String newRole) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Account a = em.find(Account.class, id);
            if (a != null) {
                a.setRole(newRole);
                em.merge(a);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public void toggleUserStatus(int id) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Account a = em.find(Account.class, id);
            if (a != null) {
                a.setStatus(!a.getStatus());
                em.merge(a);
            }
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
