package com.drawingboard

class Department {

    List<Machine> machines
    String name

    static constraints = {
    }

    static hasMany = [machines: Machine]

    static belongsTo = [user: User]
}
