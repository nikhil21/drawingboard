package com.drawingboard

import com.drawingboard.common.Constants

class DepartmentController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [departmentInstanceList: Department.list(params), departmentInstanceTotal: Department.count()]
    }

    def create = {
        def departmentInstance = new Department()
        departmentInstance.properties = params
        return [departmentInstance: departmentInstance]
    }

    def save = {
        def departmentInstance = new Department(params)
        if (departmentInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'department.label', default: 'Department'), departmentInstance.id])}"
            // create one Machine with the name of Future Work For Default
            new Machine(name: Constants.FUTRE_WORK_MACHINE_NAME+"_"+departmentInstance.name, department: departmentInstance).save(flush: true)
            // create one role with ROLE_DEPARTMENTNAME
            new Role(authority: "ROLE_${departmentInstance.name.toUpperCase()}").save(flush: true)
            redirect(action: "show", id: departmentInstance.id)
        }
        else {
            render(view: "create", model: [departmentInstance: departmentInstance])
        }
    }

    def show = {
        def departmentInstance = Department.get(params.id)
        if (!departmentInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), params.id])}"
            redirect(action: "list")
        }
        else {
            [departmentInstance: departmentInstance]
        }
    }

    def edit = {
        def departmentInstance = Department.get(params.id)
        if (!departmentInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [departmentInstance: departmentInstance]
        }
    }

    def update = {
        def departmentInstance = Department.get(params.id)
        if (departmentInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (departmentInstance.version > version) {
                    
                    departmentInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'department.label', default: 'Department')] as Object[], "Another user has updated this Department while you were editing")
                    render(view: "edit", model: [departmentInstance: departmentInstance])
                    return
                }
            }
            // fetch the old machine before I can't get to it
            Machine oldMachine = Machine.findByName(Constants.FUTRE_WORK_MACHINE_NAME+"_"+departmentInstance.name)
            departmentInstance.properties = params
            if (!departmentInstance.hasErrors() && departmentInstance.save(flush: true)) {
                // need to edit the name of future work machine as well
                // now maybe if the name has changed I need to edit the name of the future machine as well
                oldMachine.name = Constants.FUTRE_WORK_MACHINE_NAME+"_"+departmentInstance.name
                // make sure that the old machine is saved as well
                if (oldMachine.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'department.label', default: 'Department'), departmentInstance.id])}"
                    redirect(action: "show", id: departmentInstance.id)
                }
                else {
                    render(view: "edit", model: [departmentInstance: departmentInstance])
                }
            }
            else {
                render(view: "edit", model: [departmentInstance: departmentInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def departmentInstance = Department.get(params.id)
        if (departmentInstance) {
            try {
                departmentInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'department.label', default: 'Department'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'department.label', default: 'Department'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), params.id])}"
            redirect(action: "list")
        }
    }
}
