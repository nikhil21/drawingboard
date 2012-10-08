<%--
  Created by IntelliJ IDEA.
  User: shweta
  Date: 7/10/12
  Time: 6:21 PM
  To change this template use File | Settings | File Templates.
--%>



<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <title><g:message code="shaping.title"/></title>
    <style>
    .column { width: 170px; float: left; padding-bottom: 100px; }
    .portlet { margin: 0 1em 1em 0; }
    .portlet-header { margin: 0.3em; padding-bottom: 4px; padding-left: 0.2em; }
    .portlet-header .ui-icon { float: right; }
    .portlet-content { padding: 0.4em; }
    .ui-sortable-placeholder { border: 1px dotted black; visibility: visible !important; height: 50px !important; }
    .ui-sortable-placeholder * { visibility: hidden; }
    </style>
    <script>
        $(function() {
            $( ".column" ).sortable({
                connectWith: ".column"
            });

            $( ".portlet" ).addClass( "ui-widget ui-widget-content ui-helper-clearfix ui-corner-all" )
                    .find( ".portlet-header" )
                    .addClass( "ui-widget-header ui-corner-all" )
                    .prepend( "<span class='ui-icon ui-icon-minusthick'></span>")
                    .end()
                    .find( ".portlet-content" );

            $( ".portlet-header .ui-icon" ).click(function() {
                $( this ).toggleClass( "ui-icon-minusthick" ).toggleClass( "ui-icon-plusthick" );
                $( this ).parents( ".portlet:first" ).find( ".portlet-content" ).toggle();
            });

            $( ".column" ).disableSelection();
        });
    </script>
</head>
<body>
<div id="body">
    <div id="content">
        <div class="demo">

            <div class="column">

                <div class="portlet">
                    <div class="portlet-header">Feeds</div>
                    <div class="portlet-content">Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
                </div>

                <div class="portlet">
                    <div class="portlet-header">News</div>
                    <div class="portlet-content">Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
                </div>

            </div>

            <div class="column">

                <div class="portlet">
                    <div class="portlet-header">Shopping</div>
                    <div class="portlet-content">Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
                </div>

            </div>

            <div class="column">

                <div class="portlet">
                    <div class="portlet-header">Links</div>
                    <div class="portlet-content">Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
                </div>

                <div class="portlet">
                    <div class="portlet-header">Images</div>
                    <div class="portlet-content">Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
                </div>

            </div>

        </div>
    </div>

    <div class="clear"></div>
</div>
</body>
</html>
