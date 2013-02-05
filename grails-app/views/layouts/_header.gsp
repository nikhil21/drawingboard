<%--
  Created by IntelliJ IDEA.
  Date: 7/10/12
  Time: 5:20 PM
  To change this template use File | Settings | File Templates.
--%>

<div id="header">
    <h1>
        <a href="/">
            <img src="${resource(dir:'images', file: 'PGI_Logo.png')}" />
        </a>
    </h1>
    <h2>your website slogan here</h2>
    <div class="clear"></div>
</div>
<div id="nav">
    <ul>
       <li class="start">
           <g:link uri="/">Home</g:link>
        </li>
        <li>
            <sec:ifLoggedIn>
                <g:link controller="scheduler" action="main2" >Enter Program</g:link>
            </sec:ifLoggedIn>
            <sec:ifNotLoggedIn>
                <g:link controller="scheduler" action="main3" >Enter Program</g:link>
            </sec:ifNotLoggedIn>
            %{--<g:link controller="login" action="index" >Enter Program</g:link>--}%
        </li>
        %{--<li>
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