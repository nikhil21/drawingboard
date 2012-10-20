package com.drawingboard

import com.drawingboard.ENUM.QueueType

class Queue {

    String jobNo
    String pin
//    QueueType queueType
    Integer queueOrder

    static constraints = {
    }

    static belongsTo = [machine: Machine]

    @Override
    public String toString() {
        return "Queue Id :"+id+", JobNo : "+jobNo+", Pin : "+pin+", QueueOrder :"+queueOrder+", Machine [Id : "+machine.id+", name : "+machine+"]";
    }
}
