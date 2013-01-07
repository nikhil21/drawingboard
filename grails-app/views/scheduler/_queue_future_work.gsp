<div class="portlet" id="queue-${queue?.id}">
    <div class="portlet-header">${queue?.jobNo}</div>
    <div class="portlet-content">
        JobNo : <g:textField name="queue-${queue?.id}.jobNo" value="${queue?.jobNo}" style="width: 60%"/>
    </div>
    <div class="portlet-content">
        Pin : <g:textField name="queue-${queue?.id}.pin" value="${queue?.pin}" style="width: 72%"/>
    </div>
    <div class="portlet-content">
        Quantity : <g:textField name="queue-${queue?.id}.quantity" value="${queue?.quantity}" style="width: 50%"/>
    </div>

    <g:hiddenField name="queue-${queue?.id}.id" id="queue-${queue?.id}.id" value="${queue?.id}" />
    <g:hiddenField name="queue-${queue?.id}.queueOrder" id="queue-${queue?.id}.queueOrder" value="${queue?.queueOrder}" />
    <g:hiddenField name="queue-${queue?.id}.machine.id" id="queue-${queue?.id}.machine.id" value="${queue?.machine?.id}" />

    <div class="department">
       <g:render template="department1" model="[queueId:queue?.id, departmentList : departmentList, departmentID: departmentID]" />
    </div>
</div>