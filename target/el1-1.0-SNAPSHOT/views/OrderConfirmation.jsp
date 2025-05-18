<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>
</head>
<body>
    
   
    
    <div>
        <h1 class="text-center mb-4">Order Confirmation</h1>

        <!-- Course Information -->
        <div>
            <h3>Course Details</h3>
            <div>
                <span>Course Title:</span>
                <c:out value="${course.title}"/>
            </div>
            <div>
                <span>Price:</span>
                <c:out value="${course.price}"/> VND
            </div>
            <div>
                <span>Category:</span>
                <c:out value="${course.category.name}"/>
            </div>
           
        </div>

        <!-- Order Information -->
        <div>
            <h3>Order Details</h3>
            <div>
                <span>Order ID:</span>
                <c:out value="${order.orderId}"/>
            </div>
            <div>
                <span>Order Date:</span>
                <c:out value="${order.orderDate}"/>
            </div>
            <div>
                <span>Total Price:</span>
                <c:out value="${order.totalPrice}"/> VND
            </div>
            
        </div>

        <!-- Payment Information -->
        <div>
            <h3>Payment Details</h3>
            <div>
                <span>Payment ID:</span>
                <c:out value="${payment.paymentId}"/>
            </div>
            <div>
                <span>Amount:</span>
                <c:out value="${payment.amount}"/> VND
            </div>
            <div>
                <span>Payment Date:</span>
                <c:out value="${payment.paymentDate}"/>
            </div>
            <div>
                <span>Payment Method:</span>
                <c:out value="${payment.paymentMethod}"/>
            </div>
            <div>
                <span>Status:</span>
                <c:out value="${payment.status}"/>
            </div>
        </div>

        <!-- Payment Confirmation Form -->
        <form action="${pageContext.request.contextPath}/buycourse" method="post" class="text-center">
            <input type="hidden" name="paymentId" value="${payment.paymentId}"/>
            <button type="submit">Confirm Payment</button>
        </form>
    </div>

</body>
</html>
