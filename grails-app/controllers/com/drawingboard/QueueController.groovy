package com.drawingboard

class QueueController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [queueInstanceList: Queue.list(params), queueInstanceTotal: Queue.count()]
    }

    def create = {
        def queueInstance = new Queue()
        queueInstance.properties = params
        return [queueInstance: queueInstance]
    }

    def save = {
        def queueInstance = new Queue(params)
        if (queueInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'queue.label', default: 'Queue'), queueInstance.id])}"
            redirect(action: "show", id: queueInstance.id)
        }
        else {
            render(view: "create", model: [queueInstance: queueInstance])
        }
    }

    def show = {
        def queueInstance = Queue.get(params.id)
        if (!queueInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'queue.label', default: 'Queue'), params.id])}"
            redirect(action: "list")
        }
        else {
            [queueInstance: queueInstance]
        }
    }

    def edit = {
        def queueInstance = Queue.get(params.id)
        if (!queueInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'queue.label', default: 'Queue'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [queueInstance: queueInstance]
        }
    }

    def update = {
        def queueInstance = Queue.get(params.id)
        if (queueInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (queueInstance.version > version) {
                    
                    queueInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'queue.label', default: 'Queue')] as Object[], "Another user has updated this Queue while you were editing")
                    render(view: "edit", model: [queueInstance: queueInstance])
                    return
                }
            }
            queueInstance.properties = params
            if (!queueInstance.hasErrors() && queueInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'queue.label', default: 'Queue'), queueInstance.id])}"
                redirect(action: "show", id: queueInstance.id)
            }
            else {
                render(view: "edit", model: [queueInstance: queueInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'queue.label', default: 'Queue'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def queueInstance = Queue.get(params.id)
        if (queueInstance) {
            try {
                queueInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'queue.label', default: 'Queue'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'queue.label', default: 'Queue'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'queue.label', default: 'Queue'), params.id])}"
            redirect(action: "list")
        }
    }
}
