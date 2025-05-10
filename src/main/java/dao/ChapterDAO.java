package DAO;

import Model.Chapter;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;

public class ChapterDAO {

    private EntityManager entityManager;

    public ChapterDAO(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public void save(Chapter chapter) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(chapter);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        }
    }

    public Chapter findById(Long id) {
        return entityManager.find(Chapter.class, id);
    }

    public List<Chapter> findAll() {
        return entityManager.createQuery("SELECT c FROM Chapter c", Chapter.class).getResultList();
    }

    public void update(Chapter chapter) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(chapter);
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
            Chapter chapter = entityManager.find(Chapter.class, id);
            if (chapter != null) {
                entityManager.remove(chapter);
            }
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        }
    }
}
