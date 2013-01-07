package com.drawingboard

import com.drawingboard.common.Constants
import com.drawingboard.server.QueueCO
import com.drawingboard.server.QueueBL

class SchedulerController {

    def index = { }
    def main = {
        println "params are ${params}"
        List<Department> departmentList = Department.list()
        Department currentDepartment = Department.get(params.int('departmentID'))?: departmentList[0]
        List<Machine> machineList = [];
        Machine futureWork = null
        // if there is a current department then only try to get the Machines
        if (currentDepartment) {
            // if no id is passed, default to the first department
            machineList = Machine.findAllByDepartmentAndNameNotEqual(currentDepartment, Constants.FUTRE_WORK_MACHINE_NAME+"_"+currentDepartment.name)
            // pass the Future Work Machine explicitly
            futureWork = Machine.findByName(Constants.FUTRE_WORK_MACHINE_NAME+"_"+currentDepartment.name)
        }

        render(view:  'main1', model: [departmentID:currentDepartment.id,departmentList: departmentList, machineList: machineList, futureWork: futureWork ])

    }

    def main2 = {
        println "params are ${params}"
        List<Department> departmentList = Department.list()
        Department currentDepartment = Department.get(params.int('departmentID'))?: departmentList[0]
        List<Machine> machineList = [];
        Machine futureWork = null
        // if there is a current department then only try to get the Machines
        if (currentDepartment) {
            // if no id is passed, default to the first department
            machineList = Machine.findAllByDepartmentAndNameNotEqual(currentDepartment, Constants.FUTRE_WORK_MACHINE_NAME+"_"+currentDepartment.name)
            // pass the Future Work Machine explicitly
            futureWork = Machine.findByName(Constants.FUTRE_WORK_MACHINE_NAME+"_"+currentDepartment.name)
        }

        render(view:  'main2', model: [departmentID:currentDepartment.id,departmentList: departmentList, machineList: machineList, futureWork: futureWork ])

    }

    def update = {
        //params.each{ println "::"+it }

        List<Queue> queueList = Queue.findAllByMachineInList(Machine.findAllByDepartment(Department.get(params.int('departmentID'))))
        String departmentID;
        Department department;
        Machine machine;
        queueList.each{ Queue queue ->
            QueueCO queueCO = new QueueCO();
            bindData(queueCO, params["queue-${queue.id}"])

            if (params["queue_${queue.id}.departmentChange"] && params["queue_${queue.id}.departmentID"]){
                departmentID = params["queue_${queue.id}.departmentID"];
                department = Department.findById(Integer.parseInt(departmentID))
                machine = Machine.findByDepartmentAndNameIlike(department,Constants.FUTRE_WORK_MACHINE_NAME+"%")

                if (machine){
                    queueCO.machine=machine
                }
                println "\n::::after binding1::::"+queueCO
            } else{
                println "\n::::after binding2::::"+queueCO
            }

            if(queue.id!=null){
                QueueBL bl = new QueueBL()
                bl.saveQueue(queueCO)
            }
        }

        redirect(action:'main2', params:[departmentID:params.int('departmentID')])
    }
}
