<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Edit Course</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="number"], textarea, select {
            width: 100%;
            max-width: 500px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        button {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
        }
        button:hover {
            background-color: #45a049;
        }
        .delete-btn {
            background-color: #d9534f;
        }
        .delete-btn:hover {
            background-color: #c9302c;
        }
        hr {
            margin: 20px 0;
        }
        .chapter, .lesson, .file-media {
            margin-left: 20px;
            padding: 10px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 10px;
        }
        .file-media {
            margin-left: 40px;
            background-color: #f9f9f9;
        }
        .error {
            color: red;
        }
        .success {
            color: green;
        }
    </style>
</head>
<body>
    <h2>Edit Course</h2>
    
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
    <c:if test="${not empty message}">
        <p class="success">${message}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/teacher/edit-course" method="post">
        <input type="hidden" name="courseId" value="${course.courseId}"/>
        <div class="form-group">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" value="${course.title}" required>
        </div>
        <div class="form-group">
            <label for="price">Price:</label>
            <input type="number" id="price" name="price" value="${course.price}" step="0.01" min="0" required>
        </div>
        <div class="form-group">
            <label for="thumbnail">Thumbnail:</label>
            <input type="text" id="thumbnail" name="thumbnail" value="${course.thumbnail}" placeholder="Enter image path">
            <a href="${pageContext.request.contextPath}/select-image" target="_blank">Choose Image</a>
            <c:if test="${not empty course.thumbnail}">
                <img src="${pageContext.request.contextPath}/${course.thumbnail}" alt="Preview" width="100"/>
            </c:if>
        </div>
        <div class="form-group">
            <label for="categoryId">Category:</label>
            <select id="categoryId" name="categoryId" required>
                <option value="">-- Select Category --</option>
                <c:forEach var="category" items="${categories}">
                    <option value="${category.categoryId}" ${category.categoryId == course.category.categoryId ? 'selected' : ''}>
                        ${category.name}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="descriptionContent">Description:</label>
            <textarea id="descriptionContent" name="descriptionContent" rows="5" required>${course.description.content}</textarea>
        </div>
        <button type="submit" name="action" value="updateCourse">Update Course</button>
    </form>

    <hr>

    <h3>Chapters</h3>

    <form action="${pageContext.request.contextPath}/teacher/edit-course" method="post">
        <input type="hidden" name="courseId" value="${course.courseId}"/>
        <div class="form-group">
            <label for="chapterTitle">New Chapter Title:</label>
            <input type="text" id="chapterTitle" name="chapterTitle" required/>
        </div>
        <div class="form-group">
            <label for="chapterOrder">Chapter Order:</label>
            <input type="number" id="chapterOrder" name="chapterOrder" required min="0" step="1"/>
        </div>
        <button type="submit" name="action" value="addChapter">Add Chapter</button>
    </form>

    <c:forEach var="chapter" items="${course.chapters}">
        <div class="chapter">
            <p>Chapter Title: ${chapter.title} (Order: ${chapter.chapterOrder})</p>
            
            <form action="${pageContext.request.contextPath}/teacher/edit-course" method="post" style="display:inline;">
                <input type="hidden" name="chapterId" value="${chapter.chapterId}"/>
                <input type="hidden" name="courseId" value="${course.courseId}"/>
                <input type="text" name="chapterTitle" value="${chapter.title}" required/>
                <input type="number" name="chapterOrder" value="${chapter.chapterOrder}" required min="0" step="1"/>
                <button type="submit" name="action" value="updateChapter">Update Chapter</button>
            </form>
            
            <form action="${pageContext.request.contextPath}/teacher/edit-course" method="post" style="display:inline;">
                <input type="hidden" name="chapterId" value="${chapter.chapterId}"/>
                <input type="hidden" name="courseId" value="${course.courseId}"/>
                <button type="submit" class="delete-btn" name="action" value="delChapter" onclick="return confirm('Are you sure you want to delete this chapter?')">Delete Chapter</button>
            </form>
            
            <h4>Lessons in ${chapter.title}</h4>
            <c:forEach var="lesson" items="${chapter.lessons}">
                <div class="lesson">
                    <p>${lesson.title} (Index: ${lesson.lessonIndex})</p>
                    <p>Description: ${lesson.description}</p>
                    
                    <form action="${pageContext.request.contextPath}/teacher/edit-course" method="post" style="display:inline;">
                        <input type="hidden" name="lessonId" value="${lesson.lessonId}"/>
                        <input type="hidden" name="chapterId" value="${chapter.chapterId}"/>
                        <div class="form-group">
                            <label for="lessonTitle_${lesson.lessonId}">Title:</label>
                            <input type="text" id="lessonTitle_${lesson.lessonId}" name="lessonTitle" value="${lesson.title}" required/>
                        </div>
                        <div class="form-group">
                            <label for="lessonIndex_${lesson.lessonId}">Index:</label>
                            <input type="number" id="lessonIndex_${lesson.lessonId}" name="lessonIndex" value="${lesson.lessonIndex}" required min="0" step="1"/>
                        </div>
                        <div class="form-group">
                            <label for="lessonDescription_${lesson.lessonId}">Description:</label>
                            <textarea id="lessonDescription_${lesson.lessonId}" name="lessonDescription" rows="3">${lesson.description}</textarea>
                        </div>
                        <button type="submit" name="action" value="updateLesson">Update Lesson</button>
                    </form>

                    <form action="${pageContext.request.contextPath}/teacher/edit-course" method="post" style="display:inline;">
                        <input type="hidden" name="lessonId" value="${lesson.lessonId}"/>
                        <input type="hidden" name="chapterId" value="${chapter.chapterId}"/>
                        <button type="submit" class="delete-btn" name="action" value="deleteLesson" onclick="return confirm('Are you sure you want to delete this lesson?')">Delete Lesson</button>
                    </form>

                    <h5>File Media in ${lesson.title}</h5>
                    <c:forEach var="fileMedia" items="${lesson.fileMedias}">
                        <div class="file-media">
                            <p>File: ${fileMedia.fileName} (Type: ${fileMedia.fileType})</p>
                            <p>URL: <a href="${fileMedia.fileUrl}" target="_blank">${fileMedia.fileUrl}</a></p>
                            
                            <form action="${pageContext.request.contextPath}/teacher/edit-course" method="post" style="display:inline;">
                                <input type="hidden" name="fileMediaId" value="${fileMedia.id}"/>
                                <input type="hidden" name="lessonId" value="${lesson.lessonId}"/>
                                <input type="hidden" name="chapterId" value="${chapter.chapterId}"/>
                                <div class="form-group">
                                    <label for="fileName_${fileMedia.id}">File Name:</label>
                                    <input type="text" id="fileName_${fileMedia.id}" name="fileName" value="${fileMedia.fileName}" required/>
                                </div>
                                <div class="form-group">
                                    <label for="fileType_${fileMedia.id}">File Type:</label>
                                    <input type="text" id="fileType_${fileMedia.id}" name="fileType" value="${fileMedia.fileType}"/>
                                </div>
                                <div class="form-group">
                                    <label for="fileUrl_${fileMedia.id}">File URL:</label>
                                    <input type="text" id="fileUrl_${fileMedia.id}" name="fileUrl" value="${fileMedia.fileUrl}" required/>
                                </div>
                                <button type="submit" name="action" value="updateFileMedia">Update File Media</button>
                            </form>

                            <form action="${pageContext.request.contextPath}/teacher/edit-course" method="post" style="display:inline;">
                                <input type="hidden" name="fileMediaId" value="${fileMedia.id}"/>
                                <input type="hidden" name="lessonId" value="${lesson.lessonId}"/>
                                <input type="hidden" name="chapterId" value="${chapter.chapterId}"/>
                                <button type="submit" class="delete-btn" name="action" value="deleteFileMedia" onclick="return confirm('Are you sure you want to delete this file media?')">Delete File Media</button>
                            </form>
                        </div>
                    </c:forEach>

                    <form action="${pageContext.request.contextPath}/teacher/edit-course" method="post">
                        <input type="hidden" name="lessonId" value="${lesson.lessonId}"/>
                        <input type="hidden" name="chapterId" value="${chapter.chapterId}"/>
                        <input type="hidden" name="fileId" value="<%= java.util.UUID.randomUUID().toString() %>"/>
                        <div class="form-group">
                            <label for="fileName_${lesson.lessonId}">New File Name:</label>
                            <input type="text" id="fileName_${lesson.lessonId}" name="fileName" required/>
                        </div>
                        <div class="form-group">
                            <label for="fileType_${lesson.lessonId}">File Type:</label>
                            <input type="text" id="fileType_${lesson.lessonId}" name="fileType"/>
                        </div>
                        <div class="form-group">
                            <label for="fileUrl_${lesson.lessonId}">File URL:</label>
                            <input type="text" id="fileUrl_${lesson.lessonId}" name="fileUrl" required/>
                        </div>
                        <button type="submit" name="action" value="addFileMedia">Add File Media</button>
                    </form>
                </div>
            </c:forEach>

            <form action="${pageContext.request.contextPath}/teacher/edit-course" method="post">
                <input type="hidden" name="chapterId" value="${chapter.chapterId}"/>
                <input type="hidden" name="lessonId" value="<%= java.util.UUID.randomUUID().toString() %>"/>
                <div class="form-group">
                    <label for="lessonTitle_${chapter.chapterId}">New Lesson Title:</label>
                    <input type="text" id="lessonTitle_${chapter.chapterId}" name="lessonTitle" required/>
                </div>
                <div class="form-group">
                    <label for="lessonIndex_${chapter.chapterId}">Lesson Index:</label>
                    <input type="number" id="lessonIndex_${chapter.chapterId}" name="lessonIndex" required min="0" step="1"/>
                </div>
                <div class="form-group">
                    <label for="lessonDescription_${chapter.chapterId}">Description:</label>
                    <textarea id="lessonDescription_${chapter.chapterId}" name="lessonDescription" rows="3"></textarea>
                </div>
                <button type="submit" name="action" value="addLesson">Add Lesson</button>
            </form>
        </div>
    </c:forEach>

</body>
</html>