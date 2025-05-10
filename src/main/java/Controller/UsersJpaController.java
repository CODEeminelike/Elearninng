package Controller;



import Model.Users;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;

public class UsersJpaController {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("MyWebAppPU");

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Users user) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public List<Users> findAllUsers() {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery("SELECT u FROM Users u", Users.class).getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Users user) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(user);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void delete(int id) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Users user = em.find(Users.class, id);
            if (user != null) {
                em.remove(user);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}