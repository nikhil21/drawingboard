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
        %{--<li class="start"><a href="index.html">Home</a></li>
        <li><a href="examples.html">Examples</a></li>
        <li><a href="#">Products</a></li>
        <li><a href="#">Solutions</a></li>
        <li class="end"><a href="#">Contact</a></li>--}%
        <li class="start">
            <g:link controller="shaping" action="main" >Shaping</g:link>
        </li>
        <li>
            <g:link controller="department" action="list" >Department</g:link>
        </li>
        <li>
            <g:link controller="queue" action="list" >Queue</g:link>
        </li>
        <li>
            <g:link controller="machine" action="list" >Machine</g:link>
        </li>
        <li class="end">
            <g:link controller="shaping" action="main" >Shaping</g:link>
        </li>
    </ul>
</div>