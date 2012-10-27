package com.drawingboard.server

import com.drawingboard.Machine

/**
 * Created by IntelliJ IDEA.
 * User: shweta
 * Date: 20/10/12
 * Time: 10:45 PM
 * To change this template use File | Settings | File Templates.
 */

class QueueCO {

    def id
    String jobNo
    String pin
    Integer queueOrder
    Integer quantity
    Machine machine


    public QueueCO(){

    }

    public QueueCO(def id, String jobNo, String pin, Integer queueOrder, Machine machine){
       setId(id)
       setJobNo(jobNo)
       setPin(pin)
       setQueueOrder(queueOrder)
       setMachine(machine)
    }

    public String toString() {
//        return "Queue Id :"+id+", JobNo : "+jobNo+", Pin : "+pin+", QueueOrder : "+queueOrder+", Quantity : "+quantity+", Machine [Id : "+machine.id+", name : "+machine+"]";
        return "QueueCO Id :"+id+", JobNo : "+jobNo+", Pin : "+pin+", QueueOrder :"+queueOrder+", Machine : "+machine;
    }
}
