package com.drawingboard

class MachineController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [machineInstanceList: Machine.list(params), machineInstanceTotal: Machine.count()]
    }

    def create = {
        def machineInstance = new Machine()
        machineInstance.properties = params
        return [machineInstance: machineInstance]
    }

    def save = {
        def machineInstance = new Machine(params)
        if (machineInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'machine.label', default: 'Machine'), machineInstance.id])}"
            redirect(action: "show", id: machineInstance.id)
        }
        else {
            render(view: "create", model: [machineInstance: machineInstance])
        }
    }

    def show = {
        def machineInstance = Machine.get(params.id)
        if (!machineInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'machine.label', default: 'Machine'), params.id])}"
            redirect(action: "list")
        }
        else {
            [machineInstance: machineInstance]
        }
    }

    def edit = {
        def machineInstance = Machine.get(params.id)
        if (!machineInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'machine.label', default: 'Machine'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [machineInstance: machineInstance]
        }
    }

    def update = {
        def machineInstance = Machine.get(params.id)
        if (machineInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (machineInstance.version > version) {
                    
                    machineInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'machine.label', default: 'Machine')] as Object[], "Another user has updated this Machine while you were editing")
                    render(view: "edit", model: [machineInstance: machineInstance])
                    return
                }
            }
            machineInstance.properties = params
            if (!machineInstance.hasErrors() && machineInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'machine.label', default: 'Machine'), machineInstance.id])}"
                redirect(action: "show", id: machineInstance.id)
            }
            else {
                render(view: "edit", model: [machineInstance: machineInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'machine.label', default: 'Machine'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def machineInstance = Machine.get(params.id)
        if (machineInstance) {
            try {
                machineInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'machine.label', default: 'Machine'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'machine.label', default: 'Machine'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'machine.label', default: 'Machine'), params.id])}"
            redirect(action: "list")
        }
    }
}
