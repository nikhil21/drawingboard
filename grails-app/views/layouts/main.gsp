<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>genesis - Free CSS Template by spyka Webmaster</title>
    <link rel="stylesheet" href="${resource(dir: 'css',file:'styles.css')}" type="text/css" />
    <g:javascript library="jquery" plugin="jquery"/>
    <link rel="stylesheet" href="${resource(dir: 'css',file:'jquery-ui-1.8.24.custom.css')}" type="text/css" />
    <script type="text/javascript" src="${resource(dir: 'js',file: 'jquery-ui-1.8.24.custom.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css',file:'jquery.ui.theme.css')}" type="text/css" />
    <g:layoutHead />
</head>
<body>
<div id="container">
    <g:render template="/layouts/header" />
    <g:layoutBody/>
    %{--<g:render template="/layouts/footer" />--}%
</div>
</body>
</html>