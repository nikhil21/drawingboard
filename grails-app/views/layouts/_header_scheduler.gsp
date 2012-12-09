<div id="nav">
    <ul>
        <li class="start">
            <g:link uri="/">Home</g:link>
        </li>

        <g:each in="${departmentList}" var="department" status="index" >
            <li>
                <g:link class="tabs" controller="scheduler" action="main2" params="[departmentID: department.id]" >${department?.name}</g:link>
            </li>
        </g:each>
    </ul>
</div>