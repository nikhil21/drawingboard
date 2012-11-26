package com.drawingboard

import com.drawingboard.common.Constants
import com.drawingboard.server.QueueCO
import com.drawingboard.server.QueueBL
import org.apache.commons.beanutils.converters.IntegerArrayConverter

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

    def test = {
       def list = Queue.findAllByMachine(Machine.get(1)).sort {Queue queue-> queue.queueOrder }
        println "list is ${list}"

    }

    def test1 = {
       println "------>>"+ Queue.findAllByMachine(Machine.get(2)).sort {Queue qu-> qu.queueOrder }
    }

    def update = {
        params.each{ println "::"+it }

        List<Queue> queueList = Queue.findAllByMachineInList(Machine.findAllByDepartment(Department.get(params.int('departmentID'))))
        queueList.each{ Queue queue ->
            QueueCO queueCO = new QueueCO();
            println "::::before binding::::"+queueCO
            bindData(queueCO, params["queue-${queue.id}"])
            println "::::after binding::::"+queueCO

            if(queue.id!=null){
                QueueBL bl = new QueueBL()
                bl.saveQueue(queueCO)
            }
        }

        redirect(action:'main', params:[departmentID:params.int('departmentID')])
    }

    def update2 = {
        params.each{ println "::"+it }

        List<Queue> queueList = Queue.findAllByMachineInList(Machine.findAllByDepartment(Department.get(params.int('departmentID'))))
        queueList.each{ Queue queue ->
            QueueCO queueCO = new QueueCO();
            println "::::before binding::::"+queueCO
            bindData(queueCO, params["queue-${queue.id}"])
            println "::::after binding::::"+queueCO

            if(queue.id!=null){
                QueueBL bl = new QueueBL()
                bl.saveQueue(queueCO)
            }
        }

        redirect(action:'main2', params:[departmentID:params.int('departmentID')])
    }
}
