<%--
  Created by IntelliJ IDEA.
  User: shweta
  Date: 7/10/12
  Time: 5:20 PM
  To change this template use File | Settings | File Templates.
--%>

<div id="header">
    <h1><a href="/">genesis</a></h1>
    <h2>your website slogan here</h2>
    <div class="clear"></div>
</div>
<div id="nav">
    <ul>
       <li class="start">
           <g:link uri="/">Home</g:link>
        </li>
        <li>
            <g:link controller="scheduler" action="main" >Enter Program</g:link>
        </li>
        <li>
            <g:link controller="scheduler" action="main" >Manufacturing</g:link>
        </li>
        <li>
            <g:link controller="scheduler" action="main" >Logistics</g:link>
        </li>
        <li class="end">
            <g:link controller="scheduler" action="main" >Statistics</g:link>
        </li>
    </ul>
</div>