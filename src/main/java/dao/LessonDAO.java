package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import Model.Lesson;
import java.util.ArrayList;
import java.util.List;

public class LessonDAO {

    private static final String PERSISTENCE_UNIT_NAME = "MyWebAppPU";
    private static final EntityManagerFactory factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);

    /**
     * Lưu hoặc cập nhật lesson vào cơ sở dữ liệu.
     * @param lesson Lesson cần lưu.
     * @return true nếu lưu thành công, false nếu thất bại.
     */
    public boolean saveLesson(Lesson lesson) {
        EntityManager em = factory.createEntityManager();
        try {
            em.getTransaction().begin();
            if (lesson.getLessonId() == null || lesson.getLessonId().isEmpty()) {
                System.out.println("Persisting new lesson: " + lesson.getTitle());
                em.persist(lesson);
            } else {
                System.out.println("Merging existing lesson: " + lesson.getLessonId());
                em.merge(lesson);
            }
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Error in saveLesson: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Tìm lesson theo ID.
     * @param lessonId ID của lesson.
     * @return Lesson nếu tìm thấy, null nếu không tồn tại.
     */
    public Lesson findById(String lessonId) {
        EntityManager em = factory.createEntityManager();
        try {
            System.out.println("Finding lesson by ID: " + lessonId);
            Lesson lesson = em.find(Lesson.class, lessonId);
            if (lesson != null) {
                System.out.println("Found lesson: " + lesson.getTitle());
            } else {
                System.out.println("No lesson found for ID: " + lessonId);
            }
            return lesson;
        } catch (Exception e) {
            System.err.println("Error in findById: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Lấy tất cả lesson.
     * @return Danh sách lesson, rỗng nếu không có hoặc gặp lỗi.
     */
    public List<Lesson> findAll() {
        EntityManager em = factory.createEntityManager();
        try {
            System.out.println("Finding all lessons");
            TypedQuery<Lesson> query = em.createQuery("SELECT l FROM Lesson l", Lesson.class);
            List<Lesson> lessons = query.getResultList();
            System.out.println("Found " + lessons.size() + " lessons");
            return lessons;
        } catch (Exception e) {
            System.err.println("Error in findAll: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * Xóa lesson theo ID.
     * @param lessonId ID của lesson cần xóa.
     * @return true nếu xóa thành công, false nếu không tìm thấy hoặc gặp lỗi.
     */
    public boolean deleteLesson(String lessonId) {
        EntityManager em = factory.createEntityManager();
        try {
            em.getTransaction().begin();
            Lesson lesson = em.find(Lesson.class, lessonId);
            if (lesson != null) {
                System.out.println("Deleting lesson: " + lesson.getTitle());
                em.remove(lesson);
                em.getTransaction().commit();
                return true;
            } else {
                System.out.println("No lesson found to delete for ID: " + lessonId);
                em.getTransaction().commit();
                return false;
            }
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Error in deleteLesson: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Tìm lesson theo ID chapter.
     * @param chapterId ID của chapter.
     * @return Danh sách lesson, rỗng nếu không có hoặc gặp lỗi.
     */
    public List<Lesson> findByChapterId(Long chapterId) {
        EntityManager em = factory.createEntityManager();
        try {
            System.out.println("Finding lessons for chapterId: " + chapterId);
            TypedQuery<Lesson> query = em.createQuery(
                "SELECT l FROM Lesson l WHERE l.chapter.chapterId = :chapterId ORDER BY l.lessonIndex ASC", Lesson.class);
            query.setParameter("chapterId", chapterId);
            List<Lesson> lessons = query.getResultList();
            System.out.println("Found " + lessons.size() + " lessons for chapterId: " + chapterId);
            return lessons;
        } catch (Exception e) {
            System.err.println("Error in findByChapterId: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }
}