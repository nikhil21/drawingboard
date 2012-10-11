package com.drawingboard

class Department {

    String name

    static constraints = {
    }

    @Override
    public String toString() {
        return name;
    }



    static hasMany = [machines: Machine]

}
