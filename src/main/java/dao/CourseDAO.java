package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import Model.Course;
import java.util.ArrayList;
import java.util.List;

public class CourseDAO {

    private static final String PERSISTENCE_UNIT_NAME = "MyWebAppPU";
    private static final EntityManagerFactory factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);

   
    public boolean saveCourse(Course course) {
        EntityManager em = factory.createEntityManager();
        try {
            em.getTransaction().begin();
            if (course.getCourseId() == null) {
                System.out.println("Persisting new course: " + course.getTitle());
                em.persist(course);
            } else {
                System.out.println("Merging existing course: " + course.getCourseId());
                em.merge(course);
            }
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Error in saveCourse: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

   
    public Course findById(Long courseId) {
        EntityManager em = factory.createEntityManager();
        try {
            System.out.println("Finding course by ID: " + courseId);
            Course course = em.find(Course.class, courseId);
            if (course != null) {
                System.out.println("Found course: " + course.getTitle());
            } else {
                System.out.println("No course found for ID: " + courseId);
            }
            return course;
        } catch (Exception e) {
            System.err.println("Error in findById: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

  
    public List<Course> findAll() {
        EntityManager em = factory.createEntityManager();
        try {
            System.out.println("Finding all courses");
            TypedQuery<Course> query = em.createQuery("SELECT c FROM Course c", Course.class);
            List<Course> courses = query.getResultList();
            System.out.println("Found " + courses.size() + " courses");
            return courses;
        } catch (Exception e) {
            System.err.println("Error in findAll: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
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
                System.out.println("Deleting course: " + course.getTitle());
                em.remove(course);
                em.getTransaction().commit();
                return true;
            } else {
                System.out.println("No course found to delete for ID: " + courseId);
                em.getTransaction().commit();
                return false;
            }
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Error in deleteCourse: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

  
    public List<Course> findByCategoryId(Long categoryId) {
        EntityManager em = factory.createEntityManager();
        try {
            System.out.println("Finding courses for categoryId: " + categoryId);
            TypedQuery<Course> query = em.createQuery(
                "SELECT c FROM Course c WHERE c.category.categoryId = :categoryId", Course.class);
            query.setParameter("categoryId", categoryId);
            List<Course> courses = query.getResultList();
            System.out.println("Found " + courses.size() + " courses for categoryId: " + categoryId);
            return courses;
        } catch (Exception e) {
            System.err.println("Error in findByCategoryId: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

   
    public List<Course> findByTeacherId(Long teacherId) {
        EntityManager em = factory.createEntityManager();
        try {
            System.out.println("Finding courses for accountId: " + teacherId);
            TypedQuery<Course> query = em.createQuery(
                "SELECT c FROM Course c WHERE c.teacher.accountId = :teacherId", Course.class);
            query.setParameter("teacherId", teacherId);
            List<Course> courses = query.getResultList();
            System.out.println("Found " + courses.size() + " courses for accountId: " + teacherId);
            return courses;
        } catch (Exception e) {
            System.err.println("Error in findByTeacherId: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

   
    public Course findByTitle(String title) {
        EntityManager em = factory.createEntityManager();
        try {
            System.out.println("Finding course by title: " + title);
            TypedQuery<Course> query = em.createQuery(
                "SELECT c FROM Course c WHERE c.title = :title", Course.class);
            query.setParameter("title", title);
            Course course = query.getSingleResult();
            System.out.println("Found course: " + course.getTitle());
            return course;
        } catch (NoResultException e) {
            System.out.println("No course found for title: " + title);
            return null;
        } catch (Exception e) {
            System.err.println("Error in findByTitle: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
}