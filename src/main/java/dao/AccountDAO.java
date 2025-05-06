package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import model.Account; // Import lớp Account của bạn

public class AccountDAO {

    // Tên persistence unit được định nghĩa trong META-INF/persistence.xml
    private static final String PERSISTENCE_UNIT_NAME = "MyWebAppPU"; // Thay thế bằng tên persistence unit của bạn
    private static EntityManagerFactory factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);

    public Account findByUsernameAndPassword(String username, String password) {
        EntityManager em = factory.createEntityManager();
        Account account = null;
        try {
            // **Lưu ý:** Trong thực tế, so sánh mật khẩu đã băm!
            TypedQuery<Account> query = em.createQuery(
                "SELECT a FROM Account a WHERE a.username = :username AND a.password = :password AND a.isActive = true", Account.class);
            query.setParameter("username", username);
            query.setParameter("password", password); // Cần băm mật khẩu thực tế
            account = query.getSingleResult();
        } catch (NoResultException e) {
            // Không tìm thấy tài khoản phù hợp
            account = null;
        } catch (Exception e) {
            e.printStackTrace(); // Log lỗi
            // Xử lý các lỗi khác khi truy vấn
        } finally {
            em.close();
        }
        return account;
    }

    public Account findByUsernameOrEmail(String username, String email) {
         EntityManager em = factory.createEntityManager();
        Account account = null;
        try {
            TypedQuery<Account> query = em.createQuery(
                "SELECT a FROM Account a WHERE a.username = :username OR a.email = :email", Account.class);
            query.setParameter("username", username);
            query.setParameter("email", email);
             // Sử dụng getResultList() và kiểm tra kích thước để tránh NoResultException
            // hoặc sử dụng getSingleResult() và bắt NoResultException
            account = query.getSingleResult();

        } catch (NoResultException e) {
            // Không tìm thấy tài khoản trùng lặp
             account = null;
        }
        catch (Exception e) {
             e.printStackTrace(); // Log lỗi
             // Xử lý các lỗi khác
        }
        finally {
             em.close();
        }
        return account;
    }


    public boolean saveAccount(Account account) {
        EntityManager em = factory.createEntityManager();
        try {
            em.getTransaction().begin();
            // **Lưu ý:** Băm mật khẩu trước khi lưu!
            em.persist(account); // JPA sẽ biết đây là Student thông qua Inheritance/PrimaryKeyJoinColumn
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace(); // Log lỗi, ví dụ: unique constraint violation
            return false;
        } finally {
            em.close();
        }
    }

    // Có thể thêm các phương thức khác như findById, updateAccount, deleteAccount...
}