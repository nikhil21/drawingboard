<%@ page import="com.drawingboard.Department" %>
<div id="nav">
    <ul>
        <li class="start">
            <g:link uri="/">Home</g:link>
        </li>

        %{--<g:each in="${departmentList}" var="department" status="index" >--}%
        %{--<li>--}%
        %{--<%=  department = (Department)department %>--}%
            <sec:ifLoggedIn>
                %{-- First Display All the ones which the user has full access to --}%
                <g:each in="${departmentList}" var="department" status="index" >
                    <sec:ifAnyGranted roles="ROLE_${department.name.toUpperCase().trim()}">
                        <li>
                            <g:link class="${department.id == departmentID ? 'active' : ''}" controller="scheduler" action="main2" params="[departmentID: department.id]" >${department?.name}</g:link>
                        </li>
                    </sec:ifAnyGranted>
                </g:each>
                %{-- Now Display All the ones which the user can only see to --}%
                <g:each in="${departmentList}" var="department" status="index" >
                    <sec:ifNotGranted roles="ROLE_${department.name.toUpperCase().trim()}">
                        <li>
                            <g:link class="${department.id == departmentID ? 'active' : ''}" controller="scheduler" action="main3" params="[departmentID: department.id]" >${department?.name}</g:link>
                        </li>
                    </sec:ifNotGranted>
                </g:each>
            </sec:ifLoggedIn>

            <sec:ifNotLoggedIn>
                <g:each in="${departmentList}" var="department" status="index" >
                    <li>
                        <g:link class="${department.id == departmentID ? 'active' : ''}" controller="scheduler" action="main3" params="[departmentID: department.id]" >${department?.name}</g:link>
                    </li>
                </g:each>
            </sec:ifNotLoggedIn>
                %{--<h4>${department.name.toUpperCase()}</h4>--}%
        %{--</g:each>--}%
    </ul>
</div>