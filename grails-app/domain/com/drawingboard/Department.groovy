package com.drawingboard

class Department {

    String name

    static constraints = {
        name(unique: true)
    }

    @Override
    public String toString() {
        return name;
    }



    static hasMany = [machines: Machine]

}
