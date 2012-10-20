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
            machineList = Machine.findAllByDepartmentAndNameNotEqual(currentDepartment, Constants.FUTRE_WORK_MACHINE_NAME)
            // pass the Future Work Machine explicitly
            futureWork = Machine.findByName(Constants.FUTRE_WORK_MACHINE_NAME)
        }

        render(view:  'main1', model: [departmentList: departmentList, machineList: machineList, futureWork: futureWork ])

    }

    def test = {
       def list = Queue.findAllByMachine(Machine.get(1)).sort {Queue queue-> queue.queueOrder }
        println "list is ${list}"

    }

    def test1 = {
       println "------>>"+ Queue.findAllByMachine(Machine.get(2)).sort {Queue qu-> qu.queueOrder }
    }

    def update = {
        params.each{ println "::"+it }
        for (int i=1;i<5;i++){
            QueueCO queue = new QueueCO();
            println "::::::::"+queue
            bindData(queue, params["queue-${i}"])
            println "::::::::"+queue

            QueueBL bl = new QueueBL()
            bl.saveQueue(queue)
        }


        redirect(actionName:main)
    }
}
