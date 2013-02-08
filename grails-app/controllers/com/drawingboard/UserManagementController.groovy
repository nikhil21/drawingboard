package com.drawingboard

import grails.plugins.springsecurity.Secured
import grails.plugins.springsecurity.ui.UserController

@Secured(['IS_AUTHENTICATED_FULLY'])
class UserManagementController {

    def index = {

        redirect(controller: 'user')
    }
}
