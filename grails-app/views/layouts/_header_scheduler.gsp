<%@ page import="com.drawingboard.Department" %>
<div style="float: right;">
    <g:link uri="/" style="background: url(../images/skin/house.png) center left no-repeat;color: #333;
    padding-left: 20px;">Home</g:link>
</div>
<sec:ifLoggedIn>
                <div id="mcts1">
                    %{-- First Display All the ones which the user has full access to --}%
                    <g:each in="${departmentList}" var="department" status="index" >
                        <sec:ifAnyGranted roles="ROLE_${department.name.toUpperCase().trim()}">
                                <g:link class="${department.id == departmentID ? 'active' : ''}" controller="scheduler" action="main2" params="[departmentID: department.id]" >
                                    ${department?.name}
                                    <img src="../images/grails_logo.png" style="opacity: 0;height: 20px; width: 5px; "/>
                                </g:link>
                        </sec:ifAnyGranted>
                    </g:each>

                    %{-- Now Display All the ones which the user can only see to --}%
                    <g:each in="${departmentList}" var="department" status="index" >
                        <sec:ifNotGranted roles="ROLE_${department.name.toUpperCase().trim()}">
                                <g:link class="${department.id == departmentID ? 'active' : ''}" controller="scheduler" action="main3" params="[departmentID: department.id]" >
                                    ${department?.name}
                                    <img src="../images/grails_logo.png" style="opacity: 0;height: 20px; width: 5px; "/>
                                </g:link>
                        </sec:ifNotGranted>
                    </g:each>
                </div>

</sec:ifLoggedIn>

<sec:ifNotLoggedIn>
                <div id="mcts1">
                    <g:each in="${departmentList}" var="department" status="index" >
                        <g:link style=" text-decoration: none;padding-left: 5px;" class="${department.id == departmentID ? 'active' : ''}" controller="scheduler" action="main3" params="[departmentID: department.id]" >
                            ${department?.name}
                            <img src="../images/grails_logo.png" style="opacity: 0;height: 20px; width: 5px; "/>
                        </g:link>
                    </g:each>
                </div>
</sec:ifNotLoggedIn>