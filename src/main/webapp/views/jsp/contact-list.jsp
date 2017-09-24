<!DOCTYPE html>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:url value="/api/get_contacts" var="getContactsUrl" />
<c:url value="/api/create_contact" var="createContactUrl" />
<c:url value="/api/" var="var2" />
<c:url value="/api/get_contacts?page=" var="getContactPageUrl" />

<c:url value="/api/get_contact/" var="getContactByIdUrl" />
<c:url value="/api/delete_contact" var="deleteContactsUrl" />

<html lang="en">
<head>
    <link href="../../css/styles.css" rel="stylesheet">
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/font-awesome.min.css" rel="stylesheet">
    <link href="../../css/navbar.css" rel="stylesheet">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>

<!-- Navigation -->
<%@include file="components/contact-navbar.jsp"%>

<div class="container">

    <div class="row">
        <div class="panel panel-default text-left">
            <div class="panel-body">
                <h3>Your contacts</h3>
            </div>
        </div>
        <button type="button" class="btn btn-danger btn-md" onclick="deleteCheckedContacts()">
            <i class="fa fa-trash-o fa-lg" aria-hidden="true"></i> Delete
        </button>
        <a type="button" class="btn btn-warning btn-md" href="${createContactUrl}">
            <i class="fa fa-pencil fa-lg" aria-hidden="true"></i> New contact
        </a>
        <button type="button" class="btn btn-info btn-md" onclick="">
            <i class="fa fa-envelope-o fa-lg" aria-hidden="true"></i> Send email
        </button>
        <hr>

        <table class="table table-striped">
            <thead>
            <tr>
                <th><input type="checkbox" id="check-all-contacts" onclick="setAllContactsChecked()" /></th>
                <th>Full name</th>
                <th>Birthday</th>
                <th>Address</th>
                <th>Company</th>
            </tr>
            </thead>
            <c:if test="${not empty contactList}">
            <tbody>
            <c:forEach var="contact" items="${contactList}">
                <tr>
                    <td><input type="checkbox" name="is_contact_selected" value="${contact.contactId}"/></td>
                    <td><a href="${getContactByIdUrl}${contact.contactId}">
                        <c:out value="${contact.firstName} ${contact.patronymic} ${contact.surname}"/>
                    </a></td>
                    <td><c:out value="${contact.birthday}"/></td>
                    <td><c:out value="${contact.address.country}, ${contact.address.city}, ${contact.address.address}, ${contact.address.index}"/></td>
                    <td><c:out value="${contact.company}"/></td>
                    <td class="col-xs-2">
                        <div class="btn-group">
                            <button class="btn btn-sm btn-danger" onclick="">
                                <i class="fa fa-trash-o fa-lg"></i>
                            </button>
                            <button class="btn btn-sm btn-warning" onclick="">
                                <i class="fa fa-pencil fa-lg"></i>
                            </button>
                            <button class="btn btn-sm btn-info">
                                <i class="fa fa-envelope-o fa-lg"></i>
                            </button>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
            </c:if>
        </table>

        <%--Declare variable for current page and count of contacts --%>
        <c:set var="currentPage" scope ="session" value="${param.page}"/>

        <%--For displaying Page numbers--%>
        <ul class="pagination pull-right">

            <%--For displaying Previous link except for the 1st page --%>
            <li class="<c:if test="${currentPage == 1}">disabled</c:if>">
                <a href="<c:if test="${currentPage != 1}">${getContactPageUrl}${currentPage - 1}</c:if>"
                   class="<c:if test="${currentPage == 1}">disabled</c:if>">
                    <i class="fa fa-arrow-left" aria-hidden="true"></i>
                </a>
            </li>

            <%--For displaying all available pages--%>
            <c:forEach begin="1" end="${pageCount}" var="i">
                <c:choose>
                    <c:when test="${currentPage eq i}">
                        <li class="active"><a>${i}</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${getContactPageUrl}${i}">${i}</a> </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <%--For displaying Next link --%>
            <li class="<c:if test="${currentPage == pageCount}">disabled</c:if>">
                <a href="<c:if test="${currentPage != pageCount}">${getContactPageUrl}${currentPage + 1}</c:if>"
                   class="<c:if test="${currentPage == pageCount}">disabled</c:if>">
                    <i class="fa fa-arrow-right" aria-hidden="true"></i>
                </a>
            </li>
        </ul>
    </div>
    <!-- /.row -->
</div>
<!-- /.container -->

<!-- Javascript functions -->
<script src="../../js/contact-list.js"></script>
</html>

