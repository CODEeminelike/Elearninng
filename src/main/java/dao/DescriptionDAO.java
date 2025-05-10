package DAO;

import Model.Description;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;

public class DescriptionDAO {

    private EntityManager entityManager;

    public DescriptionDAO(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public void save(Description description) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(description);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        }
    }

    public Description findById(Long id) {
        return entityManager.find(Description.class, id);
    }

    public List<Description> findAll() {
        return entityManager.createQuery("SELECT d FROM Description d", Description.class).getResultList();
    }

    public void update(Description description) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(description);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        }
    }

    public void delete(Long id) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Description description = entityManager.find(Description.class, id);
            if (description != null) {
                entityManager.remove(description);
            }
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        }
    }
}
