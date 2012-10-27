

<%@ page import="com.drawingboard.Queue" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'queue.label', default: 'Queue')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${queueInstance}">
            <div class="errors">
                <g:renderErrors bean="${queueInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="jobNo"><g:message code="queue.jobNo.label" default="Job No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: queueInstance, field: 'jobNo', 'errors')}">
                                    <g:textField name="jobNo" value="${queueInstance?.jobNo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="machine"><g:message code="queue.machine.label" default="Machine" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: queueInstance, field: 'machine', 'errors')}">
                                    <g:select name="machine.id" from="${com.drawingboard.Machine.list()}" optionKey="id" value="${queueInstance?.machine?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="pin"><g:message code="queue.pin.label" default="Pin" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: queueInstance, field: 'pin', 'errors')}">
                                    <g:textField name="pin" value="${queueInstance?.pin}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="quantity"><g:message code="queue.quantity.label" default="Quantity" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: queueInstance, field: 'quantity', 'errors')}">
                                    <g:textField name="quantity" value="${fieldValue(bean: queueInstance, field: 'quantity')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="queueOrder"><g:message code="queue.queueOrder.label" default="Queue Order" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: queueInstance, field: 'queueOrder', 'errors')}">
                                    <g:textField name="queueOrder" value="${fieldValue(bean: queueInstance, field: 'queueOrder')}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
