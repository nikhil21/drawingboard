package com.drawingboard

import com.drawingboard.ENUM.QueueType

class Queue {

    String jobNo
    String pin
//    QueueType queueType
    Integer order

    static constraints = {
    }

    static belongsTo = [machine: Machine]

}
