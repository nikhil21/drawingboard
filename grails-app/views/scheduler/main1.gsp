<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="scheduler" />
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

        <g:each in="${machineList}" var="machine" status="index">
            %{--${index}--}%
            <g:if test="${index <2}">
                <div style="float: left;" id="machine-${machine.id}">
                    <div class="title">
                        <Strong>${machine?.name}</Strong>
                    </div>
                    <div class="column">
                        <g:set var="queueList" value="${com.drawingboard.Queue.findAllByMachine(machine)?.sort {com.drawingboard.Queue qu-> qu.queueOrder }}" />
                        %{--<g:set var="queueList" value="${Queue.findAllByMachine(machine)}" />--}%
                        <g:each in="${queueList}" var="queue" status="queueIdx">
                            <div class="portlet" id="queue-${queue.id}">
                                <g:if test="${queueIdx == 0}">
                                    <div class="portlet-header">WIP</div>
                                    <div class="portlet-content">${queue?.jobNo}</div>
                                    <div class="portlet-content">${queue?.pin}</div>
                                </g:if>
                                <g:else>
                                    <div class="portlet-header">Queue#${queueIdx}</div>
                                    <div class="portlet-content">${queue?.jobNo}</div>
                                    <div class="portlet-content">${queue?.pin}</div>
                                </g:else>
                            </div>
                        </g:each>
                    </div>
                </div>
            </g:if>
        </g:each>


        <div style="float: right;">
            <div class="title">
                <Strong>${futureWork?.name}</Strong>
            </div>
            <div class="column">
                <g:each in="${com.drawingboard.Queue.findAllByMachine(futureWork)?.sort {com.drawingboard.Queue qu-> qu.queueOrder }}" var="queue" status="queueIdx">
                    <div class="portlet" id="queue-future-${futureWork.id}-${queue.id}">
                        <div class="portlet-header">Queue#${queueIdx}</div>
                        <div class="portlet-content">${queue?.jobNo}</div>
                        <div class="portlet-content">${queue?.pin}</div>
                    </div>
                </g:each>
            </div>
        </div>

        <g:each in="${machineList}" var="machine" status="index">
        %{--${index}--}%
            <g:if test="${index >=2}">
                <div style="float: left;" id="machine-${machine.id}">
                    <div class="title">
                        <Strong>${machine?.name}</Strong>
                    </div>
                    <div class="column">
                        <g:set var="queueList" value="${com.drawingboard.Queue.findAllByMachine(machine)?.sort {com.drawingboard.Queue qu-> qu.queueOrder }}" />
                        <g:each in="${queueList}" var="queue" status="queueIdx">
                            <div class="portlet" id="queue-${queue.id}">
                                <g:if test="${queueIdx == 0}">
                                    <div class="portlet-header">WIP</div>
                                    <div class="portlet-content">${queue?.jobNo}</div>
                                    <div class="portlet-content">${queue?.pin}</div>
                                </g:if>
                                <g:else>
                                    <div class="portlet-header">Queue#${queueIdx}</div>
                                    <div class="portlet-content">${queue?.jobNo}</div>
                                    <div class="portlet-content">${queue?.pin}</div>
                                </g:else>
                            </div>
                        </g:each>
                    </div>
                </div>
            </g:if>
        </g:each>

    </div>
</div>
<script type="text/javascript">
    $('[id^="machine-"]').each(function(){
        var machineId = this.id;
        var queueId = "";
//console.debug(this);
        console.debug(machineId);
        if($('#'+machineId).children('div.column').children('div[id^="queue-"]')){
            queueId = $('#'+machineId).children('div.column').children('div[id^="queue-"]');
            console.debug(queueId);
        }
    });
</script>
<div class="clear"></div>
</body>
</html>
