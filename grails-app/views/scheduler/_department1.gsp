<div class="portlet-content department">
    Department : <g:select name="queue_${queueId}.departmentID" from="${departmentList}" optionKey="id" value="${departmentID}" style="width: 50%"/>
    <g:hiddenField name="queue_${queueId}.departmentChange" value="" />
</div>
<script type="text/javascript">
    var currentDepartmentID = '${departmentID}';
    $('select[name$="departmentID"]').change(function(){
        var selectedDepartmentID = $('select[name="queue_${queueId}.departmentID"]').val();
        if(currentDepartmentID!=selectedDepartmentID) {
            $('[name="queue_${queueId}.departmentChange"]').attr('value','true');
            $('#submit').click();
        }
        else
            $('[name="queue_${queueId}.departmentChange"]').attr('value','');
    });
</script>
