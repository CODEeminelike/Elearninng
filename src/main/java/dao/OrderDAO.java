package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import Model.Order;
import Model.Student;

public class OrderDAO {
    private static final String PERSISTENCE_UNIT_NAME = "MyWebAppPU";
    private static final EntityManagerFactory factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);

    public boolean saveOrder(Order order) {
        EntityManager em = factory.createEntityManager();
        try {
            em.getTransaction().begin();

            // Lấy Student từ Order
            Student student = order.getStudent();
            if (student != null) {
                // Đảm bảo Student được quản lý bởi EntityManager
                student = em.merge(student);
                // Thêm Order vào danh sách orders của Student
                student.getOrders().add(order);
            }

            // Lưu Order
            em.persist(order);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Error in saveOrder: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}