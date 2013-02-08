package com.drawingboard

import com.drawingboard.common.Constants
import com.drawingboard.server.QueueCO
import com.drawingboard.server.QueueBL
import com.sun.image.codec.jpeg.JPEGCodec
import com.sun.image.codec.jpeg.JPEGImageEncoder
import grails.plugins.springsecurity.Secured
import gui.ava.html.image.generator.HtmlImageGenerator
import org.apache.commons.io.FileUtils
import org.codehaus.groovy.grails.commons.ConfigurationHolder

import javax.imageio.ImageIO
import javax.imageio.ImageReadParam
import javax.imageio.ImageReader
import javax.imageio.stream.ImageInputStream
import java.awt.Graphics2D
import java.awt.Image
import java.awt.image.BufferedImage


class SchedulerController {

    def springSecurityService
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

//    @Secured('ROLE_ADMIN')
    /**
     * Used When The User Is Logged In
     */
    def main2 = {
        println "params are ${params}"
//        println "user has roles ${springSecurityService.currentUser.getAuthorities().authority}"
        List<Department> departmentList = Department.list()
//        Department currentDepartment = Department.get(params.int('departmentID'))?: departmentList[0]
//        Department currentDepartment = Department.get(params.int('departmentID'))?: Department.findByName(springSecurityService.currentUser)
        Department currentDepartment = Department.get(params.int('departmentID'))?: null
        List<Machine> machineList = [];
        Machine futureWork = null
        // if there is a current department then only try to get the Machines
        if (currentDepartment) {
            // if no id is passed, default to the first department
            machineList = Machine.findAllByDepartmentAndNameNotEqual(currentDepartment, Constants.FUTRE_WORK_MACHINE_NAME+"_"+currentDepartment.name)
            // pass the Future Work Machine explicitly
            futureWork = Machine.findByName(Constants.FUTRE_WORK_MACHINE_NAME+"_"+currentDepartment.name)
        }

        render(view:  'main2', model: [departmentID:currentDepartment?.id,departmentList: departmentList, machineList: machineList, futureWork: futureWork ])

    }

    /**
     * Used when the user is not logged in
     */
    def main3 = {
        println "params are ${params}"
//        println "user has roles ${springSecurityService.currentUser.getAuthorities().authority}"
        List<Department> departmentList = Department.list()
//        Department currentDepartment = Department.get(params.int('departmentID'))?: departmentList[0]
//        Department currentDepartment = Department.get(params.int('departmentID'))?: Department.findByName(springSecurityService.currentUser)
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

        render(view:  'main3', model: [departmentID:currentDepartment?.id,departmentList: departmentList, machineList: machineList, futureWork: futureWork ])

    }

    def update = {
        //params.each{ println "::"+it }
        println "In update !!"
        List<Queue> queueList = Queue.findAllByMachineInList(Machine.findAllByDepartment(Department.get(params.int('departmentID'))))
        Integer depId = params.int('departmentID')
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

        if (depId) {
            println "There is some department ID, so I will make the image.."
            makeImage(depId)
        }
        redirect(action:'main2', params:[departmentID:params.int('departmentID')])
    }

    void makeImage(Integer departmentId) {
        String url = "\'http://localhost:8080/scheduler/scheduler/main2?departmentID=${departmentId}\'"
        String departmentName = Department.findById(departmentId).name
        String pathToDirectory = ConfigurationHolder.config.path.to.directory
        String pathToPhantom = ConfigurationHolder.config.path.to.phantom
        String depName = "\'${pathToDirectory+departmentName}.jpg\'"

        println "depname is ${depName}"

        String fileStr = "var page = require('webpage').create();" +
                "         page.viewportSize = { width: 1920, height: 1080 }; \n" +
                "            page.open(${url}, function () {\n" +
                "            page.render(${depName});\n" +
                "            phantom.exit(); " +
                "});"

        String fileName = "${departmentName}.js"
        FileUtils.writeStringToFile(new File("${pathToDirectory + fileName}"), fileStr)

        // execute the script
//        "/home/nikhil/softwares/phantomjs-1.8.1-linux-i686/bin/phantomjs ${pathToDirectory}${fileName}".execute().waitFor()
        "${pathToPhantom} ${pathToDirectory}${fileName}".execute().waitFor()

        println "done !!"
    }

}
