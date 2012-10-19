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
        <g:form id="form" name="form" controller="scheduler" action="update" >
        <g:each in="${machineList}" var="machine" status="index">
            <g:if test="${index <2}">
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

                                %{--<g:hiddenField name="machine-${index}.queue.id" value="${queue.id}" />--}%
                                %{--<g:hiddenField name="machine-${index}.queue.jobNo" value="${queue.jobNo}" />--}%
                                %{--<g:hiddenField name="machine-${index}.queue.pin" value="${queue.pin}" />--}%
                                %{--<g:hiddenField name="machine-${index}.queue.queueOrder" value="${queue.queueOrder}" />--}%
                                %{--<g:hiddenField name="machine-${index}.queue.machine.id" value="${queue.machine.id}" />--}%
                            </div>
                        </g:each>
                    </div>
                    %{--<g:hiddenField name="machine-${index}.id" value="${machine.id}"/>--}%
                    %{--<g:hiddenField name="machine-${index}.name" value="${machine.name}"/>--}%
                </div>
            </g:if>
        </g:each>


        <div style="float: right;" id="machine-F">
            <div class="title">
                <Strong>${futureWork?.name}</Strong>
            </div>
            <div class="column">
                <g:each in="${com.drawingboard.Queue.findAllByMachine(futureWork)?.sort {com.drawingboard.Queue qu-> qu.queueOrder }}" var="queue" status="queueIdx">
                    <div class="portlet" id="queue-future-${futureWork.id}-${queue.id}">
                        <div class="portlet-header">Queue#${queueIdx}</div>
                        <div class="portlet-content">${queue?.jobNo}</div>
                        <div class="portlet-content">${queue?.pin}</div>

                        %{--<g:hiddenField name="machine-F.queue.id" value="${queue.id}" />--}%
                        %{--<g:hiddenField name="machine-F.queue.jobNo" value="${queue.jobNo}" />--}%
                        %{--<g:hiddenField name="machine-F.queue.pin" value="${queue.pin}" />--}%
                        %{--<g:hiddenField name="machine-F.queue.queueOrder" value="${queue.queueOrder}" />--}%
                        %{--<g:hiddenField name="machine-F.queue.machine.id" value="${queue.machine.id}" />--}%
                    </div>
                </g:each>
                %{--<g:hiddenField name="machine-F.id" value="${futureWork.id}"/>--}%
                %{--<g:hiddenField name="machine-F.name" value="${futureWork.name}"/>--}%
            </div>
        </div>

        <g:each in="${machineList}" var="machine" status="index">
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
                                %{--<g:hiddenField name="machine-${index}.queue.id" value="${queue.id}" />--}%
                                %{--<g:hiddenField name="machine-${index}.queue.jobNo" value="${queue.jobNo}" />--}%
                                %{--<g:hiddenField name="machine-${index}.queue.pin" value="${queue.pin}" />--}%
                                %{--<g:hiddenField name="machine-${index}.queue.queueOrder" value="${queue.queueOrder}" />--}%
                                %{--<g:hiddenField name="machine-${index}.queue.machine.id" value="${queue.machine.id}" />--}%
                            </div>
                        </g:each>
                    </div>
                    %{--<g:hiddenField name="machine-${index}.id" value="${machine.id}"/>--}%
                    %{--<g:hiddenField name="machine-${index}.name" value="${machine.name}"/>--}%
                </div>
            </g:if>
        </g:each>
    </div>
    <div class="clear"></div>
    <div>
            <g:submitButton name="submit" id="submit" value="Update" style="width: 150px;margin-left: 43%;"/>
    </div>

    </g:form>
</div>
<script type="text/javascript">
    var $form = $('#form');
    $form.submit(function() {
        alert("Submitting");
        $('div[id^="machine-"]').each(function(){
            var machineId = this.id;
            var queueId = "";
            var $queue;
            console.debug(machineId);
            $('#'+machineId).children('div.column').children('div[id^="queue-"]').each(function(){
                $queue = $('#'+machineId).children('div.column').children('div[id^="queue-"]');
                queueId = $queue.attr("id");
                console.debug(">>"+queueId);
                //alert(machineId+">>"+queueId);
            });
        });
    });
</script>
<div class="clear"></div>
</body>
</html>
