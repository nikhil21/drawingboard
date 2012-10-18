<div id="nav">
    <ul>
        <li class="start">
            <g:link uri="/">Home</g:link>
        </li>

        <g:each in="${departmentList}" var="department" status="index" >
            <li>
                <g:link controller="scheduler" action="main" params="[departmentID: department.id]" >${department?.name}</g:link>
            </li>
        </g:each>

        %{--<li>
            <g:link controller="scheduler" action="main" >Shaping</g:link>
        </li>
        <li>
            <g:link controller="scheduler" action="main" >Manufacturing</g:link>
        </li>
        <li>
            <g:link controller="scheduler" action="main" >Logistics</g:link>
        </li>
        <li class="end">
            <g:link controller="scheduler" action="main" >Statistics</g:link>
        </li>--}%
    </ul>
</div>