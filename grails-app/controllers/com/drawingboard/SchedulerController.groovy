package com.drawingboard

class SchedulerController {

    def index = { }
    def main = {
        println "params are ${params}"
        List<Department> departmentList = Department.list()
        Department currentDepartment = Department.get(params.int('departmentID'))?: departmentList[0]
        List<Machine> machineList;
        // if there is a current department then only try to get the Machines
        if (currentDepartment) {
            // if no id is passed, default to the first department
            machineList = Machine.findAllByDepartment(currentDepartment)

        }

        render(view:  'main1', model: [departmentList: departmentList, machineList: machineList])

    }

    def test = {
       def list = Queue.findAllByMachine(Machine.get(1)).sort {Queue queue-> queue.queueOrder }
        println "list is ${list}"

    }

    def test1 = {
       println "------>>"+ Queue.findAllByMachine(Machine.get(2)).sort {Queue qu-> qu.queueOrder }
    }
}
