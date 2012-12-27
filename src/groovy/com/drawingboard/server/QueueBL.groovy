package com.drawingboard.server

import com.drawingboard.Queue

/**
 * Created by IntelliJ IDEA.
 * User: shweta
 * Date: 20/10/12
 * Time: 11:30 PM
 * To change this template use File | Settings | File Templates.
 */
class QueueBL {

    public Queue getQueue(QueueCO queueCO){
        Queue queue = Queue.get(queueCO.id)
        queue.setJobNo(queueCO.jobNo)
        queue.setPin(queueCO.pin)
        queue.setQueueOrder(queueCO.queueOrder)
        queue.setQuantity(queueCO.quantity)
        queue.setMachine(queueCO.machine)
        
        return queue
    }

    public QueueCO getQueueCO(Queue queue){
        QueueCO queueCO = new QueueCO()
        queueCO.setId(queueCO.id)
        queueCO.setJobNo(queueCO.jobNo)
        queueCO.setPin(queueCO.pin)
        queueCO.setQueueOrder(queueCO.queueOrder)
        queue.setQuantity(queueCO.quantity)
        queueCO.setMachine(queueCO.machine)

        return queueCO
    }
    
    public void saveQueue(Queue queue){
        queue.save(flush: true)
        println("Queue saved : "+queue)
    }
    
    public void saveQueue(QueueCO queueCO){
        Queue queue = getQueue(queueCO)
        saveQueue(queue)
    }
}
