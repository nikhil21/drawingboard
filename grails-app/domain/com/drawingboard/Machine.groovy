package com.drawingboard

class Machine {

    String name

    static constraints = {
    }

    static hasMany = [queues: Queue]

    static belongsTo = [department: Department]

    @Override
    public String toString() {
        return name;
    }
}
