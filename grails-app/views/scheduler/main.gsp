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
    .column { width: 200px; float: left; padding-bottom: 100px;border : 10px solid #000000;margin-right: 20px;margin-bottom: 20px;}
    .portlet { border : 10px solid #000000; }
    .portlet-header { margin: 0.3em; padding-bottom: 4px; padding-left: 0.2em; }
    .portlet-header .ui-icon { float: right; }
    .portlet-content { padding: 0.4em; }
    .ui-sortable-placeholder { border: 1px dotted black; visibility: visible !important; height: 50px !important; }
    .ui-sortable-placeholder * { visibility: hidden; }

    .title{background-color : #ffffff; border: 10px solid #000000;width: 200px;}
    .demo{margin-left:100px;}
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
    <div class="demo">



        <div style="float: left;">
            <div class="title">
                <Strong>GP30</Strong>
            </div>
            <div class="column">

                <div class="portlet">
                    <div class="portlet-header">WIP</div>
                    <div class="portlet-content">....</div>
                </div>

                <div class="portlet">
                    <div class="portlet-header">Queue#1</div>
                    <div class="portlet-content">....</div>
                </div>

                <div class="portlet">
                    <div class="portlet-header">Queue#2</div>
                    <div class="portlet-content">....</div>
                </div>

            </div>
        </div>

        <div style="float: left;">
            <div class="title">
            <Strong>MTS40</Strong>
            </div>
            <div class="column">

                <div class="portlet">
                    <div class="portlet-header">WIP</div>
                    <div class="portlet-content">....</div>
                </div>

                <div class="portlet">
                    <div class="portlet-header">Queue#1</div>
                    <div class="portlet-content">....</div>
                </div>

                <div class="portlet">
                    <div class="portlet-header">Queue#2</div>
                    <div class="portlet-content">....</div>
                </div>

            </div>
        </div>

        <div style="float: right;">
            <div class="title">
            <Strong>Future Work</Strong>
            </div>
            <div class="column">

                <div class="portlet">
                    <div class="portlet-header">Queue#1</div>
                    <div class="portlet-content">....</div>
                </div>

                <div class="portlet">
                    <div class="portlet-header">Queue#2</div>
                    <div class="portlet-content">....</div>
                </div>

                <div class="portlet">
                    <div class="portlet-header">Queue#3</div>
                    <div class="portlet-content">....</div>
                </div>

                <div class="portlet">
                    <div class="portlet-header">Queue#4</div>
                    <div class="portlet-content">....</div>
                </div>

                <div class="portlet">
                    <div class="portlet-header">Queue#5</div>
                    <div class="portlet-content">....</div>
                </div>

                <div class="portlet">
                    <div class="portlet-header">Queue#6</div>
                    <div class="portlet-content">....</div>
                </div>

            </div>
        </div>

        <div style="float: left;">
            <div class="title">
            <Strong>MTS40</Strong>
            </div>
            <div class="column">

                <div class="portlet">
                    <div class="portlet-header">WIP</div>
                    <div class="portlet-content">....</div>
                </div>

                <div class="portlet">
                    <div class="portlet-header">Queue#1</div>
                    <div class="portlet-content">....</div>
                </div>

                <div class="portlet">
                    <div class="portlet-header">Queue#2</div>
                    <div class="portlet-content">....</div>
                </div>

            </div>
        </div>

        <div style="float: left">
            <div class="title">
            <Strong>MTS40</Strong>
            </div>
            <div class="column">

                <div class="portlet">
                    <div class="portlet-header">WIP</div>
                    <div class="portlet-content">....</div>
                </div>

                <div class="portlet">
                    <div class="portlet-header">Queue#1</div>
                    <div class="portlet-content">....</div>
                </div>

                <div class="portlet">
                    <div class="portlet-header">Queue#2</div>
                    <div class="portlet-content">....</div>
                </div>

            </div>
        </div>
    </div>
</div>

<div class="clear"></div>
</body>
</html>