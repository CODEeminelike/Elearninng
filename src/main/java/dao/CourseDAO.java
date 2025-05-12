package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import Model.Course;
import java.util.List;

public class CourseDAO {

    private static final String PERSISTENCE_UNIT_NAME = "MyWebAppPU";
    private static EntityManagerFactory factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);

    public boolean saveCourse(Course course) {
        EntityManager em = factory.createEntityManager();
        try {
            em.getTransaction().begin();
            if (course.getCourseId() == null) {
                em.persist(course);
            } else {
                em.merge(course);
            }
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public Course findById(Long courseId) {
        EntityManager em = factory.createEntityManager();
        try {
            return em.find(Course.class, courseId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public List<Course> findAll() {
        EntityManager em = factory.createEntityManager();
        try {
            TypedQuery<Course> query = em.createQuery("SELECT c FROM Course c", Course.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public boolean deleteCourse(Long courseId) {
        EntityManager em = factory.createEntityManager();
        try {
            em.getTransaction().begin();
            Course course = em.find(Course.class, courseId);
            if (course != null) {
                em.remove(course);
                em.getTransaction().commit();
                return true;
            }
            em.getTransaction().commit();
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public List<Course> findByCategoryId(Long categoryId) {
        EntityManager em = factory.createEntityManager();
        try {
            TypedQuery<Course> query = em.createQuery(
                "SELECT c FROM Course c WHERE c.category.categoryId = :categoryId", Course.class);
            query.setParameter("categoryId", categoryId);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public List<Course> findByTeacherId(Long teacherId) {
        EntityManager em = factory.createEntityManager();
        try {
            TypedQuery<Course> query = em.createQuery(
                "SELECT c FROM Course c WHERE c.teacher.teacherId = :teacherId", Course.class);
            query.setParameter("teacherId", teacherId);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public Course findByTitle(String title) {
        EntityManager em = factory.createEntityManager();
        try {
            TypedQuery<Course> query = em.createQuery(
                "SELECT c FROM Course c WHERE c.title = :title", Course.class);
            query.setParameter("title", title);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
}