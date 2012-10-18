
<%@ page import="com.drawingboard.Queue" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'queue.label', default: 'Queue')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'queue.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="jobNo" title="${message(code: 'queue.jobNo.label', default: 'Job No')}" />
                        
                            <th><g:message code="queue.machine.label" default="Machine" /></th>
                        
                            <g:sortableColumn property="pin" title="${message(code: 'queue.pin.label', default: 'Pin')}" />
                        
                            <g:sortableColumn property="queueOrder" title="${message(code: 'queue.queueOrder.label', default: 'Queue Order')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${queueInstanceList}" status="i" var="queueInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${queueInstance.id}">${fieldValue(bean: queueInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: queueInstance, field: "jobNo")}</td>
                        
                            <td>${fieldValue(bean: queueInstance, field: "machine")}</td>
                        
                            <td>${fieldValue(bean: queueInstance, field: "pin")}</td>
                        
                            <td>${fieldValue(bean: queueInstance, field: "queueOrder")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${queueInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
