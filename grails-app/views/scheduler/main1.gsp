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
        <g:hiddenField name="departmentID" value="${departmentID}" />
        <g:each in="${machineList}" var="machine" status="index">
            <g:if test="${index <2}">
                <div style="float: left;" id="machine-${machine.id}">
                    <g:hiddenField name="machine-${machine.id}.id" id="machine-${machine.id}.id" value="${machine.id}" />
                    <div class="title">
                        <Strong>${machine?.name}</Strong>
                    </div>
                    <div class="column">
                        <g:set var="queueList" value="${com.drawingboard.Queue.findAllByMachine(machine)?.sort {com.drawingboard.Queue qu-> qu.queueOrder }}" />
                        <g:each in="${queueList}" var="queue" status="queueIdx">
                            <div class="portlet" id="queue-${queue.id}">
                                <g:if test="${queueIdx == 0}">
                                    <div class="portlet-header">WIP</div>
                                    <div class="portlet-content">
                                        JobNo : <g:textField name="queue-${queue.id}.jobNo" value="${queue.jobNo}" style="width: 60%"/>
                                    </div>
                                    <div class="portlet-content">
                                        Pin : <g:textField name="queue-${queue.id}.pin" value="${queue.pin}" style="width: 72%"/>
                                    </div>
                                </g:if>
                                <g:else>
                                    <div class="portlet-header">Queue#${queueIdx}</div>
                                    <div class="portlet-content">
                                        JobNo : <g:textField name="queue-${queue.id}.jobNo" value="${queue.jobNo}" style="width: 60%"/>
                                    </div>
                                    <div class="portlet-content">
                                        Pin : <g:textField name="queue-${queue.id}.pin" value="${queue.pin}" style="width: 72%"/>
                                    </div>
                                </g:else>

                                <g:hiddenField name="queue-${queue.id}.id" id="queue-${queue.id}.id" value="${queue.id}" />
                                <g:hiddenField name="queue-${queue.id}.queueOrder" id="queue-${queue.id}.queueOrder" value="${queue.queueOrder}" />
                                <g:hiddenField name="queue-${queue.id}.machine.id" id="queue-${queue.id}.machine.id" value="${queue.machine.id}" />
                            </div>
                        </g:each>
                    </div>
                </div>
            </g:if>
        </g:each>


        <div style="float: right;" id="machine-F">
            <g:hiddenField name="machine-F.id" id="machine-F.id" value="${futureWork.id}" />
            <div class="title">
                <Strong><g:message code="label.futureWork" /></Strong>
            </div>
            <div class="column">
                <g:each in="${com.drawingboard.Queue.findAllByMachine(futureWork)?.sort {com.drawingboard.Queue qu-> qu.queueOrder }}" var="queue" status="queueIdx">
                    <div class="portlet" id="queue-${queue.id}">
                        <div class="portlet-header">Queue#${queueIdx}</div>
                        <div class="portlet-content">
                            JobNo : <g:textField name="queue-${queue.id}.jobNo" value="${queue.jobNo}" style="width: 60%"/>
                        </div>
                        <div class="portlet-content">
                            Pin : <g:textField name="queue-${queue.id}.pin" value="${queue.pin}" style="width: 72%"/>
                        </div>

                        <g:hiddenField name="queue-${queue.id}.id" id="queue-${queue.id}.id" value="${queue.id}" />
                        <g:hiddenField name="queue-${queue.id}.queueOrder" id="queue-${queue.id}.queueOrder" value="${queue.queueOrder}" />
                        <g:hiddenField name="queue-${queue.id}.machine.id" id="queue-${queue.id}.machine.id" value="${queue.machine.id}" />
                    </div>
                </g:each>
            </div>
        </div>

        <g:each in="${machineList}" var="machine" status="index">
            <g:if test="${index >=2}">
                <div style="float: left;" id="machine-${machine.id}">
                    <g:hiddenField name="machine-${machine.id}.id" id="machine-${machine.id}.id" value="${machine.id}" />
                    <div class="title">
                        <Strong>${machine?.name}</Strong>
                    </div>
                    <div class="column">
                        <g:set var="queueList" value="${com.drawingboard.Queue.findAllByMachine(machine)?.sort {com.drawingboard.Queue qu-> qu.queueOrder }}" />
                        <g:each in="${queueList}" var="queue" status="queueIdx">
                            <div class="portlet" id="queue-${queue.id}">
                                <g:if test="${queueIdx == 0}">
                                    <div class="portlet-header">WIP</div>
                                    <div class="portlet-content">
                                        JobNo : <g:textField name="queue-${queue.id}.jobNo" value="${queue.jobNo}" style="width: 60%"/>
                                    </div>
                                    <div class="portlet-content">
                                        Pin : <g:textField name="queue-${queue.id}.pin" value="${queue.pin}" style="width: 72%"/>
                                    </div>
                                </g:if>
                                <g:else>
                                    <div class="portlet-header">Queue#${queueIdx}</div>
                                    <div class="portlet-content">
                                        JobNo : <g:textField name="queue-${queue.id}.jobNo" value="${queue.jobNo}" style="width: 60%"/>
                                    </div>
                                    <div class="portlet-content">
                                        Pin : <g:textField name="queue-${queue.id}.pin" value="${queue.pin}" style="width: 72%"/>
                                    </div>
                                </g:else>
                                <g:hiddenField name="queue-${queue.id}.id" id="queue-${queue.id}.id" value="${queue.id}" />
                                <g:hiddenField name="queue-${queue.id}.queueOrder" id="queue-${queue.id}.queueOrder" value="${queue.queueOrder}" />
                                <g:hiddenField name="queue-${queue.id}.machine.id" id="queue-${queue.id}.machine.id" value="${queue.machine.id}" />
                            </div>
                        </g:each>
                    </div>
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
        $('div[id^="machine-"]').each(function(){
            var divMachineId = this.id;
            var machineId = $('input[name="'+divMachineId+'.id"]').attr('value');
            var queueId = "";
            var $queue;
            $('#'+divMachineId).children('div.column').children('div[id^="queue-"]').each(function(index){
                $queue = $(this);
                queueId = $queue.attr("id");
                $('input[name="'+queueId+'.machine.id"]').attr('value',machineId);
                $('input[name="'+queueId+'.queueOrder"]').attr('value',index);
            });
        });
    });
</script>
<div class="clear"></div>
</body>
</html>
