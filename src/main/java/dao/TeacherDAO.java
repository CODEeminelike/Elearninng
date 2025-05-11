package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import Model.Account;
import Model.Teacher;
import java.util.List;

public class TeacherDAO {

    private static final String PERSISTENCE_UNIT_NAME = "MyWebAppPU";
    private static EntityManagerFactory factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
    private AccountDAO accountDAO = new AccountDAO();

    // Phương thức tạo tài khoản Teacher
    public Teacher createTeacher(String username, String password, String email, String phone, String avatar, 
                                boolean isActive, String name, String bio, String qualifications) throws Exception {
        try {
            // Kiểm tra xem username hoặc email đã tồn tại chưa
            Account existingAccount = accountDAO.findByUsernameOrEmail(username, email);
            if (existingAccount != null) {
                throw new Exception("Username or email already exists: " + username + " / " + email);
            }

            // Tạo đối tượng Teacher trực tiếp
            Teacher teacher = new Teacher();
            teacher.setUsername(username);
            teacher.setPassword(password);
            teacher.setEmail(email);
            teacher.setPhone(phone);
            teacher.setAvatar(avatar);
            teacher.setActive(isActive);
            teacher.setName(name);
            teacher.setBio(bio);
            teacher.setQualifications(qualifications);

            // Lưu Teacher vào database (tự động lưu vào cả accounts và teachers)
            boolean success = accountDAO.saveAccount(teacher);
            if (!success) {
                throw new Exception("Failed to save Teacher account.");
            }

            return teacher;
        } catch (Exception e) {
            throw new Exception("Error creating Teacher account: " + e.getMessage());
        }
    }

    // Phương thức kiểm tra xem tài khoản có phải Teacher không
    public boolean isTeacher(Long accountId) throws Exception {
        EntityManager em = factory.createEntityManager();
        try {
            Teacher teacher = em.find(Teacher.class, accountId);
            return teacher != null;
        } catch (Exception e) {
            throw new Exception("Error checking if accountId " + accountId + " is Teacher: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    // Phương thức lấy thông tin Teacher theo accountId
    public Teacher getTeacherById(Long accountId) throws Exception {
        EntityManager em = factory.createEntityManager();
        try {
            Teacher teacher = em.find(Teacher.class, accountId);
            if (teacher == null) {
                throw new Exception("No Teacher found for accountId: " + accountId);
            }
            return teacher;
        } catch (Exception e) {
            throw new Exception("Error getting Teacher for accountId " + accountId + ": " + e.getMessage());
        } finally {
            em.close();
        }
    }

    // Phương thức lấy danh sách tất cả Teacher
    public List<Teacher> getAllTeachers() throws Exception {
        EntityManager em = factory.createEntityManager();
        try {
            em.getTransaction().begin();
            List<Teacher> result = em.createQuery("SELECT t FROM Teacher t", Teacher.class).getResultList();
            em.getTransaction().commit();
            return result; // Không ném ngoại lệ nếu danh sách rỗng
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new Exception("Error getting all Teachers: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    // Phương thức xóa Teacher
    public boolean removeTeacher(Long accountId) throws Exception {
        EntityManager em = factory.createEntityManager();
        try {
            em.getTransaction().begin();
            Teacher teacher = em.find(Teacher.class, accountId);
            if (teacher == null) {
                em.getTransaction().rollback();
                return false;
            }
            em.remove(teacher); // Xóa Teacher, JPA sẽ tự động xóa bản ghi trong cả accounts và teachers
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new Exception("Error removing Teacher with accountId " + accountId + ": " + e.getMessage());
        } finally {
            em.close();
        }
    }

    // Phương thức cập nhật trạng thái isActive của Teacher
    public boolean updateTeacherStatus(Long accountId, boolean isActive) throws Exception {
        EntityManager em = factory.createEntityManager();
        try {
            em.getTransaction().begin();
            Teacher teacher = em.find(Teacher.class, accountId);
            if (teacher == null) {
                em.getTransaction().rollback();
                return false;
            }
            teacher.setActive(isActive);
            em.merge(teacher);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new Exception("Error updating status for Teacher with accountId " + accountId + ": " + e.getMessage());
        } finally {
            em.close();
        }
    }
}