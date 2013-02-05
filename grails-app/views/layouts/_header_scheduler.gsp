<%@ page import="com.drawingboard.Department" %>
<div id="nav">
    <ul>
        <li class="start">
            <g:link uri="/">Home</g:link>
        </li>

        <g:each in="${departmentList}" var="department" status="index" >
            <li>
                %{--<%=  department = (Department)department %>--}%
                <sec:ifLoggedIn>
                    <sec:ifAnyGranted roles="ROLE_${department.name.toUpperCase().trim()}">
                        <g:link class="tabs" controller="scheduler" action="main2" params="[departmentID: department.id]" >${department?.name}</g:link>
                    </sec:ifAnyGranted>
                </sec:ifLoggedIn>

                <sec:ifNotLoggedIn>
                    <g:link class="tabs" controller="scheduler" action="main3" params="[departmentID: department.id]" >${department?.name}</g:link>
                </sec:ifNotLoggedIn>
                %{--<h4>${department.name.toUpperCase()}</h4>--}%
            </li>
        </g:each>
    </ul>
</div>