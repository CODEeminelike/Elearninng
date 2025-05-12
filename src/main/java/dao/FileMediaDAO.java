package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import Model.FileMedia;
import java.util.ArrayList;
import java.util.List;

public class FileMediaDAO {

    private static final String PERSISTENCE_UNIT_NAME = "MyWebAppPU";
    private static final EntityManagerFactory factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);

    /**
     * Lưu hoặc cập nhật file media vào cơ sở dữ liệu.
     * @param fileMedia FileMedia cần lưu.
     * @return true nếu lưu thành công, false nếu thất bại.
     */
    public boolean saveFileMedia(FileMedia fileMedia) {
        EntityManager em = factory.createEntityManager();
        try {
            em.getTransaction().begin();
            if (fileMedia.getId() == null) {
                System.out.println("Persisting new file media: " + fileMedia.getFileName());
                em.persist(fileMedia);
            } else {
                System.out.println("Merging existing file media: " + fileMedia.getId());
                em.merge(fileMedia);
            }
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Error in saveFileMedia: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Tìm file media theo ID.
     * @param id ID của file media.
     * @return FileMedia nếu tìm thấy, null nếu không tồn tại.
     */
    public FileMedia findById(Long id) {
        EntityManager em = factory.createEntityManager();
        try {
            System.out.println("Finding file media by ID: " + id);
            FileMedia fileMedia = em.find(FileMedia.class, id);
            if (fileMedia != null) {
                System.out.println("Found file media: " + fileMedia.getFileName());
            } else {
                System.out.println("No file media found for ID: " + id);
            }
            return fileMedia;
        } catch (Exception e) {
            System.err.println("Error in findById: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Lấy tất cả file media.
     * @return Danh sách file media, rỗng nếu không có hoặc gặp lỗi.
     */
    public List<FileMedia> findAll() {
        EntityManager em = factory.createEntityManager();
        try {
            System.out.println("Finding all file media");
            TypedQuery<FileMedia> query = em.createQuery("SELECT f FROM FileMedia f", FileMedia.class);
            List<FileMedia> fileMedias = query.getResultList();
            System.out.println("Found " + fileMedias.size() + " file media");
            return fileMedias;
        } catch (Exception e) {
            System.err.println("Error in findAll: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * Xóa file media theo ID.
     * @param id ID của file media cần xóa.
     * @return true nếu xóa thành công, false nếu không tìm thấy hoặc gặp lỗi.
     */
    public boolean deleteFileMedia(Long id) {
        EntityManager em = factory.createEntityManager();
        try {
            em.getTransaction().begin();
            FileMedia fileMedia = em.find(FileMedia.class, id);
            if (fileMedia != null) {
                System.out.println("Deleting file media: " + fileMedia.getFileName());
                em.remove(fileMedia);
                em.getTransaction().commit();
                return true;
            } else {
                System.out.println("No file media found to delete for ID: " + id);
                em.getTransaction().commit();
                return false;
            }
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Error in deleteFileMedia: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Tìm file media theo ID lesson.
     * @param lessonId ID của lesson.
     * @return Danh sách file media, rỗng nếu không có hoặc gặp lỗi.
     */
    public List<FileMedia> findByLessonId(String lessonId) {
        EntityManager em = factory.createEntityManager();
        try {
            System.out.println("Finding file media for lessonId: " + lessonId);
            TypedQuery<FileMedia> query = em.createQuery(
                "SELECT f FROM FileMedia f WHERE f.lesson.lessonId = :lessonId", FileMedia.class);
            query.setParameter("lessonId", lessonId);
            List<FileMedia> fileMedias = query.getResultList();
            System.out.println("Found " + fileMedias.size() + " file media for lessonId: " + lessonId);
            return fileMedias;
        } catch (Exception e) {
            System.err.println("Error in findByLessonId: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * Tìm file media theo fileId.
     * @param fileId Mã định danh của file media.
     * @return FileMedia nếu tìm thấy, null nếu không tồn tại.
     */
    public FileMedia findByFileId(String fileId) {
        EntityManager em = factory.createEntityManager();
        try {
            System.out.println("Finding file media by fileId: " + fileId);
            TypedQuery<FileMedia> query = em.createQuery(
                "SELECT f FROM FileMedia f WHERE f.fileId = :fileId", FileMedia.class);
            query.setParameter("fileId", fileId);
            FileMedia fileMedia = query.getSingleResult();
            System.out.println("Found file media: " + fileMedia.getFileName());
            return fileMedia;
        } catch (NoResultException e) {
            System.out.println("No file media found for fileId: " + fileId);
            return null;
        } catch (Exception e) {
            System.err.println("Error in findByFileId: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
}