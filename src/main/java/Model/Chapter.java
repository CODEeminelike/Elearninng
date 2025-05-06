package model;

import jakarta.persistence.*; // Hoặc javax.persistence.* tùy phiên bản Jakarta EE/Java EE
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects; // Cần import Objects cho equals/hashCode

@Entity
@Table(name = "chapters")
// Đã bỏ @Getter @Setter @NoArgsConstructor @AllArgsConstructor @EqualsAndHashCode
public class Chapter implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    // Đã bỏ @EqualsAndHashCode.Include
    private Long chapterId;

    @Column(nullable = false)
    private String title;

    private Integer chapterOrder; // Thứ tự trong khóa học

    // Nhiều Chapter thuộc về một Course
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id", nullable = false)
    private Course course;

    // Một Chapter có nhiều Assessment (Lesson kế thừa từ Assessment)
    @OneToMany(mappedBy = "chapter", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @OrderBy("lessonOrder ASC")
    private List<Assessment> lessons = new ArrayList<>(); // Khởi tạo ngay khi khai báo

    // Constructor không tham số (thay thế @NoArgsConstructor)
    public Chapter() {
        // Danh sách lessons đã được khởi tạo ở trên
    }

    // Constructor với các trường cơ bản và mối quan hệ ManyToOne
    // (thay thế @AllArgsConstructor, thường bao gồm các trường cơ bản và ManyToOne)
    public Chapter(Long chapterId, String title, Integer chapterOrder, Course course) {
        this.chapterId = chapterId;
        this.title = title;
        this.chapterOrder = chapterOrder;
        this.course = course;
        // Danh sách lessons đã được khởi tạo ở trên
    }

    // Nếu bạn muốn constructor bao gồm cả danh sách lessons, bạn cần tự viết
    // public Chapter(Long chapterId, ..., Course course, List<Assessment> lessons) {
    //     this.chapterId = chapterId;
    //     ...
    //     this.course = course;
    //     this.lessons = lessons;
    // }


    // Getters
    public Long getChapterId() {
        return chapterId;
    }

    public String getTitle() {
        return title;
    }

    public Integer getChapterOrder() {
        return chapterOrder;
    }

    public Course getCourse() {
        return course;
    }

    public List<Assessment> getLessons() {
        return lessons;
    }

    // Setters (Setter cho mối quan hệ ManyToOne và các trường cơ bản; Setter cho danh sách thường không được tạo)
    public void setChapterId(Long chapterId) {
        this.chapterId = chapterId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setChapterOrder(Integer chapterOrder) {
        this.chapterOrder = chapterOrder;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    // Setter cho danh sách lessons thường không được tạo

    // Phương thức equals() thủ công (thay thế @EqualsAndHashCode)
    // Dựa trên trường được đánh dấu @EqualsAndHashCode.Include trước đây (chapterId)
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Chapter chapter = (Chapter) o;
        return Objects.equals(chapterId, chapter.chapterId);
    }

    // Phương thức hashCode() thủ công (thay thế @EqualsAndHashCode)
    // Dựa trên trường được đánh dấu @EqualsAndHashCode.Include trước đây (chapterId)
    @Override
    public int hashCode() {
        return Objects.hash(chapterId);
    }
}