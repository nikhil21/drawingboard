<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="scheduler" />
    <title><g:message code="shaping.title"/></title>
    <style>
    .box {float: left;margin-right: 20px;margin-bottom: 20px;border : 5px solid #000000;}
    .column {
        width: 200px;
        float: none;
        padding-bottom: 100px;
        border : 10px solid #393939;
    }
    .portlet { border : 10px solid #000000; }
    .portlet-header { margin: 0.3em; padding-bottom: 4px; padding-left: 0.2em; }
    .portlet-header .ui-icon { float: right; }
    .portlet-content { padding: 0.4em; }
    .ui-sortable-placeholder { border: 1px dotted black; visibility: visible !important; height: 50px !important; }
    .ui-sortable-placeholder * { visibility: hidden; }

    .title{background-color : #ffffff; border: 10px solid #393939;width: 200px;color: #000000;}
    .demo{margin-left:100px;}
    </style>
    <script>
        $(function() {
            $( ".column" ).sortable({
                connectWith: ".column",
                update: function(event, ui) {
                    var queueCount = 0;
                    $(this).children('div.portlet').each(function(){
                        queueCount++;
                    });

                    if(queueCount<=0){
                        $(this).attr('style','padding-bottom:100px;');
                    } else{
                        $(this).attr('style','padding-bottom:0px;');
                    }

                    if($(this).parents('.box').attr('id')!='machine-F'){
                       $(this).children('.department').html('');
                    }

                    $('#submit').click();
                }
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
        <div style="float: left;width: 80%;">
            <g:each in="${machineList}" var="machine" status="index">
                    <div id="machine-${machine?.id}" class="box">
                        <g:hiddenField name="machine-${machine?.id}.id" id="machine-${machine?.id}.id" value="${machine?.id}" />
                        <g:set var="queueList" value="${com.drawingboard.Queue.findAllByMachine(machine)?.sort {com.drawingboard.Queue qu-> qu.queueOrder }}" />
                        <div class="title">
                            <Strong>${machine?.name}</Strong>
                        </div>
                        <div class="content">
                            <g:set var="queue" value="${queueList[0]}" />
                            <div class="title">
                                <Strong>WIP</Strong>
                            </div>
                            <g:if test="${queue}" >
                                <div class="column" style="float: none;padding-bottom: 0px;">
                                    <g:render template="queue" model="[queue:queue]" />
                                </div>
                            </g:if>
                            <g:else>
                                <div class="column" style="float: none;"></div>
                            </g:else>
                        </div>
                        <div class="content">
                            <g:set var="queue" value="${queueList[1]}" />
                            <div class="title">
                                <Strong>Queue 1</Strong>
                            </div>
                            <g:if test="${queue}" >
                                <div class="column" style="float: none;padding-bottom: 0px;">
                                    <g:render template="queue" model="[queue:queue]" />
                                </div>
                            </g:if>
                            <g:else>
                                <div class="column" style="float: none;"></div>
                            </g:else>
                        </div>
                        <div class="content">
                            <g:set var="queue" value="${queueList[2]}" />
                            <div class="title">
                                <Strong>Queue 2</Strong>
                            </div>
                            <g:if test="${queue}" >
                                <div class="column" style="float: none;padding-bottom: 0px;">
                                    <g:render template="queue" model="[queue:queue]" />
                                </div>
                            </g:if>
                            <g:else>
                                <div class="column" style="float: none;"></div>
                            </g:else>
                        </div>
                    </div>
            </g:each>
        </div>

        <g:if test="${departmentID}">
        <div id="machine-F" class="box"  style="float: left;">
            <g:hiddenField name="machine-F.id" id="machine-F.id" value="${futureWork?.id}" />
            <div class="title">
                <Strong><g:message code="label.futureWork" /></Strong>
            </div>
            <div class="content">
                <div class="column">
                    <g:if test="${futureWork!=null}">
                        <g:each in="${com.drawingboard.Queue.findAllByMachine(futureWork)?.sort {com.drawingboard.Queue qu-> qu.queueOrder }}" var="queue" status="queueIdx">
                            <g:render template="queue_future_work" model="[queue:queue, departmentList : departmentList, departmentID: departmentID]" />
                        </g:each>
                    </g:if>

                </div>
            </div>
        </div>
        </g:if>
        </div>
        <div class="clear"></div>
        <div>
            <g:if test="${departmentID}">
            <g:submitButton name="submit" id="submit" value="Update" style="width: 150px;margin-left: 43%;" />
            %{--<g:submitButton onclick="window.print();" name="print" id="print" value="Print" style="width: 150px;margin-left: 43%;"/>--}%
            </g:if>
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
            $('#'+divMachineId).children('div.content').children('div.column').children('div[id^="queue-"]').each(function(index){
                queueId = $(this).attr("id");
                $('input[name="'+queueId+'.machine.id"]').attr('value',machineId);
                $('input[name="'+queueId+'.queueOrder"]').attr('value',index);
            });
        });
    });
</script>
<div class="clear"></div>
</body>
</html>
