package model;

import jakarta.persistence.*; // Hoặc javax.persistence.* tùy phiên bản Jakarta EE/Java EE
import java.io.Serializable; // Cần Serializable nếu class implement Serializable
import java.util.ArrayList;
import java.util.List;
import java.util.Objects; // Cần import Objects cho equals/hashCode

@Entity
@Table(name = "lessons")
// Đã bỏ @Getter @Setter @NoArgsConstructor @AllArgsConstructor @EqualsAndHashCode
public class Lesson implements Serializable { // Giữ lại implements Serializable nếu cần

    @Id
    // Đã bỏ @EqualsAndHashCode.Include
    private String lessonId; // Mã định danh bài học (khóa chính)

    @Column(nullable = false)
    private String title; // Tiêu đề bài học

    @Column(columnDefinition = "TEXT")
    private String description; // Mô tả chi tiết

    private Integer lessonIndex; // Chỉ mục/thứ tự trong chương

    // Nhiều Lesson liên kết tới một Chapter
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "chapter_id", nullable = false)
    private Chapter chapter; // Tham chiếu tới Chapter

    // Một Lesson có nhiều FileMedia
    @OneToMany(mappedBy = "lesson", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<FileMedia> attachment = new ArrayList<>(); // Danh sách tệp đính kèm

    // Constructor không tham số (thay thế @NoArgsConstructor)
    public Lesson() {
        // Danh sách attachment đã được khởi tạo ở trên
    }

    // Constructor với các trường cơ bản và mối quan hệ ManyToOne
    // (@AllArgsConstructor của Lombok thường bao gồm các trường cơ bản và ManyToOne, không bao gồm collections đã khởi tạo)
    public Lesson(String lessonId, String title, String description, Integer lessonIndex, Chapter chapter) {
        this.lessonId = lessonId;
        this.title = title;
        this.description = description;
        this.lessonIndex = lessonIndex;
        this.chapter = chapter;
        // Danh sách attachment đã được khởi tạo ở trên
    }

    // Nếu bạn muốn constructor bao gồm cả danh sách attachment, bạn cần tự viết


    // Getters
    public String getLessonId() {
        return lessonId;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public Integer getLessonIndex() {
        return lessonIndex;
    }

    public Chapter getChapter() {
        return chapter;
    }

    public List<FileMedia> getAttachment() {
        return attachment;
    }

    // Setters (Setter cho các trường cơ bản và mối quan hệ ManyToOne; Setter cho danh sách thường không được tạo)
    public void setLessonId(String lessonId) {
        this.lessonId = lessonId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setLessonIndex(Integer lessonIndex) {
        this.lessonIndex = lessonIndex;
    }

    public void setChapter(Chapter chapter) {
        this.chapter = chapter;
    }

    // Setter cho danh sách attachment thường không được tạo

    // Phương thức equals() thủ công (thay thế @EqualsAndHashCode)
    // Dựa trên trường được đánh dấu @EqualsAndHashCode.Include trước đây (lessonId)
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Lesson lesson = (Lesson) o;
        return Objects.equals(lessonId, lesson.lessonId);
    }

    // Phương thức hashCode() thủ công (thay thế @EqualsAndHashCode)
    // Dựa trên trường được đánh dấu @EqualsAndHashCode.Include trước đây (lessonId)
    @Override
    public int hashCode() {
        return Objects.hash(lessonId);
    }
}