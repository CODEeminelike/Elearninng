package dao;

import jakarta.persistence.*;
import Model.Course;
import java.util.List;

public class CourseDAO {

    private static final String PERSISTENCE_UNIT_NAME = "MyWebAppPU";
    private static EntityManagerFactory factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);

    // Tìm Course theo ID
    public Course findById(Long id) {
        EntityManager em = factory.createEntityManager();
        Course course = null;
        try {
            course = em.find(Course.class, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return course;
    }

    // Lấy tất cả Course
    public List<Course> findAll() {
        EntityManager em = factory.createEntityManager();
        List<Course> list = null;
        try {
            TypedQuery<Course> query = em.createQuery("SELECT c FROM Course c", Course.class);
            list = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return list;
    }

    // Tìm Course theo tiêu đề
    public List<Course> findByTitle(String keyword) {
        EntityManager em = factory.createEntityManager();
        List<Course> list = null;
        try {
            TypedQuery<Course> query = em.createQuery(
                "SELECT c FROM Course c WHERE LOWER(c.title) LIKE :keyword", Course.class);
            query.setParameter("keyword", "%" + keyword.toLowerCase() + "%");
            list = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
        return list;
    }

    // Lưu Course mới
    public boolean saveCourse(Course course) {
        EntityManager em = factory.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(course);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // Cập nhật Course
    public boolean updateCourse(Course course) {
        EntityManager em = factory.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(course);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // Xoá Course
    public boolean deleteCourse(Long id) {
        EntityManager em = factory.createEntityManager();
        try {
            em.getTransaction().begin();
            Course course = em.find(Course.class, id);
            if (course != null) {
                em.remove(course);
                em.getTransaction().commit();
                return true;
            } else {
                em.getTransaction().rollback(); // Không có gì để xoá
                return false;
            }
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}
